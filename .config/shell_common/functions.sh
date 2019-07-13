#!/usr/bin/env dash
# No shebang line here; this file is meant to be sourced by a shell.
mkcd() {
	mkdir -p "$@"
	cd "$@" || return
}

wdir() {
	# shellcheck disable=SC2230
	PROGPATH=$(which "$1")
	PROGDIR=$(dirname "$PROGPATH")
	cd "$PROGDIR" || return
}

# transfer.sh
transfer() {
	if [ $# -eq 0 ]; then
		printf "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md\n"
		return 1
	fi
	tmpfile=$(mktemp -t transferXXX)
	if tty -s; then
		basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
		curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >>"$tmpfile"
	else
		curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >>"$tmpfile"
	fi
	cat "$tmpfile"
	rm -f "$tmpfile"
}

n() {
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
		pid=$(ps -f -u "$uid" | sed 1d | fzf -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
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
	pfu | xargs kill -"$signal"
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

# shellcheck source=file_mngment.sh
. "$XDG_CONFIG_HOME/shell_common/file_mngment.sh"
