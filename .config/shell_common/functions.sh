#!/usr/bin/env dash
# No shebang line here; this file is meant to be sourced by a shell.
mkcd() {
	mkdir -p "$@"
	cd "$@" || return
}

mkcp() {
	mkdir -p "$(dirname $2)"
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

n() {
	export NNN_TMPFILE="$XDG_CACHE_HOME/nnn/lastd"
	nnn "$@"

	if [ -f "$NNN_TMPFILE" ]; then
		# shellcheck source=/dev/null
		. "$NNN_TMPFILE"
		rm "$NNN_TMPFILE"
	fi
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

imgurup() {
	curl -H "Referer: https://imgur.com/upload" -F "Filedata=@$1" https://imgur.com/upload \
		| jq \
		| $PAGER
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

# shellcheck source=functions_ghq.sh
. "$(dirname "$0")/functions_ghq.sh"
