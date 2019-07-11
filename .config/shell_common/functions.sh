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
	ps -x | fzf | (
		read -r pid _ # pid is the first arg. GNU read will strip whitespace and stuff.
		echo "$pid"
	)
}

fuzzykill() {
	pf | xargs kill -"$1"
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
