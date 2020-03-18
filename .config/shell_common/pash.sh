#!/bin/sh
mypash() {
	case $1 in
		g*) # pash git; run git commands on the pash dir
			cd "${PASH_DIR:=${XDG_DATA_HOME:=$HOME/.local/share}/pash}" || echo 'could not cd to PASH_DIR' >&2
			shift
			git "$@"
			cd - >/dev/null || echo 'could not cd to original directory' >&2
			;;
		p*) # p means just the password
			shift
			case $1 in
				s*)
					shift
					command pash show "$@" | sed 1q
					;;
				c*)
					shift
					pash pass show "$@" | wl-copy -no
					;;
				*)
					echo "invalid command" >&2
					return 1
					;;
			esac
			;;
		u*) # u means just the username
			shift
			case $1 in
				s*)
					shift
					command pash show "$@" | sed -n 2p | sed 's/^login: //'
					;;
				c*)
					shift
					pash username show "$@" | wl-copy -n # uname isn't sensitive; don't use -o
					;;
				*)
					echo "invalid command" >&2
					return 1
					;;
			esac
			;;
		i*) # info: show everything except the password
			shift
			case $1 in
				s*)
					shift
					command pash show "$@" | sed 1d
					;;
				c*)
					shift
					pash info show "$@" | wl-copy -n # info isn't sensitive; don't use -o
					;;
				*)
					echo "invalid command" >&2
					return 1
					;;
			esac
			;;
		*) command pash "$@" ;;
	esac
}

pash() {
	mypash "$@"
}

fash() {
	if [ -z "$2" ]; then
		pash
	else
		case $1 in
			p* | u* | i*)
				if [ -n "$3" ]; then
					field="$1"
					cmd="$2"
					shift
					shift
					mypash "$field" "$cmd" "$(pash list | fzf -q "$@")" && return 0
				fi
				;;
			*)
				if [ -n "$2" ]; then
					cmd="$1"
					shift
					mypash "$cmd" "$(pash list | fzf -q "$@")" && return 0
				fi
				;;
		esac
		mypash "$@" "$(pash list | fzf)"
	fi
}
