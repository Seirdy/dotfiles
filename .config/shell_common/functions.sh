sohup() {
	if [ -n "$ZSH_VERSION" ]; then
		nohup "$@" detch
	elif [ -n "$BASH" ]; then
		# shellcheck disable=SC2169
		nohup "$@" &>/dev/null 2>/dev/null &
		# shellcheck disable=SC2169
		disown
	else
		return 1
	fi
}

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

editbin() {
	# shellcheck disable=SC2230
	PROGPATH=$(which "$1")
	"$EDITOR" "$PROGPATH" || return
}

# transfer.sh
transfer() {
	if [ $# -eq 0 ]; then
		printf "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md\n"
		return 1
	fi
	tmpfile=$( mktemp -t transferXXX );
	if tty -s; then
		basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
		curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> "$tmpfile"
	else
		curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> "$tmpfile"
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

