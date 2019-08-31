#!/usr/bin/env dash

# File management functions, powered by FZF and fd
# Source these and never use a file manager again!
# All commands begin with an "f" for "fuzzy" followed by 2 letters:
# 	1. p,d,e,o,c: print, display (with bat), edit, open (with default program), cd
# 	2. f,d,a:   file,directory,all
# Not every combination is possible; you can't cd into a file
# Dependencies:
# 	- lsd
# 	- fd-find
# 	- fzf
# 	- bat
# 	- openx (already included in dotfiles; see ~/.local/bin/openx)

_lsd_args='--color always --oneline'

fpa() {
	dash -c "lsd --group-dirs first $* $_lsd_args" | fzfp | awk '{print $2}'
}

fpd() {
	dash -c "exa -D $* $_lsd_args" | fzfp
}

fpf() {
	dash -c "fd -t f -d 1 -x lsd $* $_lsd_args" | fzfp
}

_display() {
	[ -n "$1" ] && bat --color always --style full "$1"
}

fdf() {
	_display "$(fpf "$@")"
}

_openx_if_set() {
	[ -n "$1" ] && openx "$1"
}

foa() {
	_openx_if_set "$(fpa "$@")"
}

fof() {
	_openx_if_set "$(fpf "$@")"
}

fod() {
	_openx_if_set "$(fpd "$@")"
}

fef() {
	to_open="$(fpf "$@")"
	[ -n "$to_open" ] && $EDITOR "$to_open"
}

fcd() {
	to_cd="$(fpd "$@")"
	# shellcheck disable=SC2164
	[ -n "$to_cd" ] && cd "$to_cd"
}
