#!/bin/sh
mkcd() {
	mkdir -p "$@"
	cd "$@" || return
}

mkcp() {
	mkdir -p "$(dirname "$2")"
	cp "$1" "$2"
}

wdir() {
	# shellcheck disable=SC2230
	progpath=$(command -v "$1")
	[ -f "$progpath" ] || echo "$1 does not seem to be a file."
	progdir=$(dirname "$progpath")
	cd "$progdir" || return
}

cdg() {
	if [ -z "$1" ]; then
		cdto=$(ghq list | fzf)
	else
		cdto=$(ghq list | fzf -q "$@")
	fi
	[ "$cdto" = '' ] || cd "$GHQ_ROOT/$cdto" || return 1
}

history_stats() {
	if [ -z "$1" ]; then
		entries=1000
	else
		entries="$1"
	fi
	history 1 \
		| awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' \
		| rg -v "./" \
		| column -c3 -s " " -t \
		| sort -nr \
		| nl \
		| head -n"$entries"
}

pf() {
	local pid
	pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

	if [ "x$pid" != "x" ]; then
		echo "$pid"
	fi
}

# list only the ones you can kill. Modified the earlier script.
pfu() {
	local pid uid
	uid=$(bash -c 'echo $UID')
	if [ "$uid" != "0" ]; then
		pid=$(ps -f -u "$uid" | sed 1d | fzf -m -q "$@" | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m -q "$@" | awk '{print $2}')
	fi

	if [ "x$pid" != "x" ]; then
		echo "$pid"
	fi
}

fkill() {
	local signal
	if [ $# -eq 0 ]; then
		signal=9
	else
		signal="$1"
	fi
	pfu "$2" | xargs kill -"$signal"
}

# jq for YAML.
# [yq](https://github.com/mikefarah/yq) uses unfamiliar syntax.
# So just convert YAML to json, run jq on it, then convert back to YAML.
# Surround the jq commands in quotes for it to be treated as a single argument
jqy() {
	yq r -j "$1" \
		| jq "$2" \
		| yq - r
}

# Start and attach to a docker container
da() {
	local cid
	cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

# Select a running docker container to stop
ds() {
	local cid
	cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker stop "$cid"
}

fbuku() {
	bmark=$(buku -p -f 5 | fzf --tac)
	index="$(echo "$bmark" | awk '{print $1}')"
	echo "index is $index"
	buku -p "$index"
	buku -o "$index"
}

bcalc() {
	echo "scale=10; $*" | bc -l
}
# shellcheck source=file_mngment.sh
. "$XDG_CONFIG_HOME/shell_common/file_mngment.sh"

# file uploading/pastebins

imgurup() {
	json_data="$(curl -H "Referer: https://imgur.com/upload" -F "Filedata=@$1" https://imgur.com/upload | jq -r '.data')"
	hash="$(echo "$json_data" | jq -r '.hashes | .[]')"
	ext="$(echo "$json_data" | jq -r '.ext')"
	echo "https://imgur.kageurufu.net/${hash}${ext}"
}

upl() {
	curl-tor --progress -F"file=@$1" https://0x0.st
}

# shareit: upload stdin to https://share.schollz.com.
# Generates a random filename if one is not provided.
shareit() {
	[ -n "$1" ] && filename="$1" || filename="$(tr -dc A-Za-z0-9 </dev/urandom | head -c 10)"
	curl-tor --progress --upload-file - "https://share.schollz.com/$filename" | sed 's#schollz\.com#schollz\.com/1#'
}

# `curlout <url> | clbin` will mirror <url> to clbin.
curlout() {
	curl-tor --progress "$@" --output -
}

# save chattiest-channels to a pastebin
share-chattiest-channels() {
	{
		chattiest-channels "$@"
		printf "\nIf you run weechat then you can run this yourself: https://git.sr.ht/~seirdy/chattiest-channels"
	} | curl-tor --progress -F "clbin=<-" https://clbin.com | wl-copy -n \
		&& wl-paste \
		&& curl-tor $(wl-paste)

}

hnopen() {
	for URL in "$@"; do
		hn view -bc "$URL"
	done
}

dnfbadstr1='^(mingw(32|64)|R-)|(\.(src|i686)|debug(info|source)\..*)$'
dnfbadstr2='^(mingw(32|64)|R-|lib|perl|python|texlive)|(\.(src|i686)|(\-(devel|doc|common)|debug(info|source)\..*))$'

# filter the output of `dnf list` and `dnf search`
dnf_filter() {
	rg -v "$dnfbadstr1" </dev/stdin
}

dnf_filter_strict() {
	awk '{print $1}' </dev/stdin | sed -e 's/\.x86_64$//' -e 's/\.noarch$//' | sort | uniq | rg -v "$dnfbadstr2"
}

_ghsearch_url() {
	formatstr=$(echo "$*" | tr ' ' '+')
	printf 'https://github.com/search?q=%s&type=Repositories' "$formatstr"
}

gitsearch() {
	$BROWSER "$(_ghsearch_url "$*")"
}

_ghsearch_starred_url() {
	baseurl=$(_ghsearch_url "$*")
	echo "${baseurl}&o=desc&s=starred"
}

gitssearch() {
	$BROWSER "$(_ghsearch_starred_url "$*")"
}

unshorten() {
	curl "https://unshorten.me/s/$1"
}

unshorten_clip() {
	unshorten "$(wl-paste)" | head -n 1 | wl-copy
}

isitup() {
	curl-tor "https://isitup.org/$1.json" -s | jq
}

# set up a git repo
git_setup() {
	git init
	git remote add origin "https://gitlab.com/Seirdy/$1.git"
	git remote add gh_mirror "https://gitlab.com/Seirdy/$1.git"
}

# shellcheck source=functions_ghq.sh
. "$(dirname "$0")/functions_ghq.sh"
. "$(dirname "$0")/pash.sh"
