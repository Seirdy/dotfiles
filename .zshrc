#!/bin/zsh
# export MANPATH="/usr/local/man:$MANPATH"
# export MANPATH="$HOME/.local/man:$MANPATH"
# export MANPATH="$HOME/.local/venvs/*/share/man:$MANPATH"
# fortune -n 70 -s computers pets
export LC_ALL=en_US.UTF-8
export COLUMNS
export ROWS
module_path+=("$HOME/.zplugin/bin/zmodules/Src")
module_path+=("$HOME/.zplugin/mod-bin/zmodules/Src")
if [ -z "$PROFILE_SET" ]; then
	# shellcheck source=.profile
	. "$HOME/.profile"
	export PROFILE_SET=2
fi

# I can't get zpmod to work on macOS
# See https://github.com/zdharma/zplugin/issues/131
if [ "$MACHINE" != 'Darwin' ]; then
	zmodload zdharma/zplugin
	# macOS has issues with gpg password input.
	# This makes password input happen in a TUI.
else
	is_tty="$(tty)"
	if [ "$is_tty" != 'not a tty' ]; then
		export GPG_TTY="$is_tty"
	fi
fi
if [ "$MACHINE" != 'Linux' ] && [ "$(podman-machine status)" = 'Running' ]; then
	eval $(podman-machine env box)
fi
# dedupe $PATH
export KEYTIMEOUT=1 # Reduces delay when entering vi-mode
## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
# An SSD can handle a large history
HISTSIZE=99999
# shellcheck disable=SC2034
SAVEHIST=90000
## History command configuration
# record timestamp of command in HISTFILE
setopt extended_history
# delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_expire_dups_first
# Don't add duplicate entries
setopt hist_ignore_dups
# ignore commands that start with space
setopt hist_ignore_space
# show command with history expansion to user before running it
setopt hist_verify
# add commands to HISTFILE in order of execution
setopt inc_append_history
# share command history data
setopt share_history
# don't display duplicates in reverse search
setopt hist_find_no_dups
# remove superfluous blanks
setopt hist_reduce_blanks


# Don't autocorrect when thefuck does it better.
unsetopt correct_all
# Muh globbing
setopt extended_glob
setopt equals
# Expansion
setopt prompt_subst
# Comments in the interactive shell; useful for copy-pasting
setopt interactivecomments
# Use colors in auto-completion
eval `dircolors`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# Send CONT signal automatically when disowning jobs
setopt auto_continue
setopt pushd_ignore_dups

# Compilation flags
export ARCHFLAGS='-arch x86_64'

export _ZL_MATCH_MODE=1
export _ZL_ECHO=1

# Completion prefs
# Completion initialization happens asynchrously when loading plugins.
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' max-errors 3 numeric
# aliases
SHELL_COMMON="$HOME/.config/shell_common"
# shellcheck source=.config/shell_common/aliases.sh
. "$SHELL_COMMON/aliases.sh"
# shellcheck source=.config/shell_common/aliases_private.sh
. "$SHELL_COMMON/aliases_private.sh" # Not committing private info
# shellcheck source=.config/shell_common/functions.sh
. "$SHELL_COMMON/functions.sh"

# keybinds and functions
function _z() { _zlua "$@"; }

function fancy_ctrl_z() {
	if [[ $#BUFFER -eq 0 ]]; then
		export BUFFER='fg'
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
# shellcheck source=/dev/null
. "$SHELL_COMMON/zsh/powerlevel10k.zsh"
# give less pretty colors
# shellcheck source=.config/less/less_termcap.sh
. "$XDG_CONFIG_HOME/less/less_termcap.sh"
# source the plugins and start completions/autosuggestions.
# shellcheck source=.config/shell_common/zsh/zplugin.zsh
. "$SHELL_COMMON/zsh/zplugin.zsh"
