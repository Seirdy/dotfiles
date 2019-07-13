#!/usr/bin/env dash

# File management functions, powered by FZF and fd
# Source these and never use a file manager again!
# All commands begin with an "f" for "fuzzy" followed by 2 letters:
# 	1. p,e,o,c: print, edit, open (with associated application), cd
# 	2. f,d,a:   file,directory,all
# Not every combination is possible; you can't cd into a file
# Dependencies:
# 	- lsd
# 	- fd-find
# 	- fzf
# 	- bat
# 	- openx (already included in dotfiles; see ~/.local/bin/openx)

_lsd_args='--color always --icon-theme fancy --oneline'
_lsd_args_icon="$_lsd_args --icon always"

fpa() {
	dash -c "lsd --group-dirs first $* $_lsd_args_icon" | fzf | awk '{print $2}'
}

_set_opts() {
	export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $*"
}

fpd() {
	orignal_opts=$FZF_DEFAULT_OPTS
	_set_opts "--height=20 --preview='lsd {} $_lsd_args_icon'"
	dash -c "fd -t d -d 1 -x lsd -d $* $_lsd_args" | fzf
	FZF_DEFAULT_OPTS=$orignal_opts
}

fpf() {
	original_opts=$FZF_DEFAULT_OPTS
	_set_opts "--preview='bat {} --color always --style header'"
	dash -c "fd -t f -d 1 -x lsd $* $_lsd_args" | fzf
	FZF_DEFAULT_OPTS=$original_opts
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
