#!/bin/zsh
# export MANPATH="/usr/local/man:$MANPATH"
# export MANPATH="$HOME/.local/man:$MANPATH"
# export MANPATH="$HOME/.local/venvs/*/share/man:$MANPATH"
# fortune -n 70 -s computers pets
export LC_ALL=en_US.UTF-8
module_path+=( "$HOME/.zplugin/bin/zmodules/Src" )
module_path+=( "$HOME/.zplugin/mod-bin/zmodules/Src" )
zmodload zdharma/zplugin
if [ "$PROFILE_SET" != 1 ]; then
	echo "PROFILE_SET initial val: \"$PROFILE_SET\""
	# shellcheck source=/home/rkumar/.profile
	. "$HOME/.profile"
	export PROFILE_SET=2
fi
# dedupe $PATH
PATH=$(zsh -fc "typeset -TU P=$PATH p; echo \$P")
MANPATH=$(zsh -fc "typeset -TU P=$MANPATH p; echo \$P")
export KEYTIMEOUT=1  # Reduces delay when entering vi-mode
## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
# An SSD can handle a large history; reduce if needed.
HISTSIZE=99999
# shellcheck disable=SC2034
SAVEHIST=50000
## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# Don't autocorrect. Use `thefuck` for that.
unsetopt correct_all
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

export _ZL_MATCH_MODE=1
export _ZL_ECHO=1

# Completion prefs
# Completion initialization happens asynchrously when loading plugins.
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' max-errors 3 numeric
# aliases
SHELL_COMMON="$HOME/.config/shell_common"
# shellcheck source=/home/rkumar/.config/shell_common/aliases.sh
. "$SHELL_COMMON/aliases.sh"  # Portable aliases
# shellcheck source=/home/rkumar/.config/shell_common/aliases_private.sh
. "$SHELL_COMMON/aliases_private.sh"  # Not committing private info

# shellcheck source=/home/rkumar/.config/shell_common/functions.sh
. "$SHELL_COMMON/functions.sh"  # POSIX-compliant shell functions

# keybinds and functions
function _z() { _zlua "$@"; }

function fancy_ctrl_z () {
  if [[ $#BUFFER -eq 0 ]]; then
    export BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy_ctrl_z
bindkey '^Z' fancy_ctrl_z
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
export PAGER="w3m"
export BAT_PAGER="less"
export _ZL_MATCH_MODE=1

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# The first argument to the function ($1) is the base path to start traversal
# See the source code (completion.{bash,zsh}) for the details.

_fzf_compgen_path() {
	fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion

_fzf_compgen_dir() {
	fd --type d --hidden --follow --exclude ".git" . "$1"
}

# source the theme
# shellcheck source=/home/rkumar/.config/shell_common/powerlevel9k.zsh
. "$SHELL_COMMON/powerlevel9k.zsh"
# source the plugins and start completions/autosuggestions.
# shellcheck source=/home/rkumar/.config/shell_common/zplugin.zsh
. "$SHELL_COMMON/zplugin.zsh"

n() {
	nnn "$@"

	if [ -f "$NNN_TMPFILE" ]; then
		# shellcheck source=/dev/null
		. "$NNN_TMPFILE"
		rm "$NNN_TMPFILE"
	fi
}

# [ -f ~/.fzf.zsh ] && . ~/.fzf.zsh  # Commented; moved to zplugin
