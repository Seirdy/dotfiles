#!/bin/zsh
export ZLE_RPROMPT_INDENT=0
# powerlevel10k instant prompt
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# export GITSTATUS_CACHE_DIR="$HOME/.local/bin"
if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-$USER.zsh" ]]; then
  source "$XDG_CACHE_HOME/p10k-instant-prompt-$USER.zsh"
fi
export COLUMNS ROWS
export ZPLG_HOME="$HOME/Executables/zinit"
export ZPFX="$ZPLG_HOME/polaris"
declare -A ZINIT
export ZINIT[HOME_DIR]="$ZPLG_HOME"
export ZINIT[BIN_DIR]="$ZINIT[HOME_DIR]/bin"
export ZINIT[PLUGINS_DIR]="$ZINIT[HOME_DIR]/plugins"
export ZINIT[COMPLETIONS_DIR]="$ZINIT[HOME_DIR]/completions"
export ZINIT[SNIPPETS_DIR]="$ZINIT[HOME_DIR]/snippets"

# user-loaded modules don't work on the statically-linked zsh build I use.
# only load them if I use the standard distro package
if [ "$0" = '/bin/zsh' ]; then
	module_path+=("$ZINIT[HOME_DIR]/bin/zmodules/Src")
	# study time spent sourcing files
	zmodload zdharma-continuum/zplugin # doesn't work with static zsh-bin
fi

if [ -z "$PROFILE_SET" ]; then
	# shellcheck source=.profile
	. "$HOME/.profile"
	export PROFILE_SET='zshrc'
fi

export KEYTIMEOUT=1 # Reduces delay when entering vi-mode
export FZ_HISTORY_CD_CMD=_zlua
## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
# An SSD can handle a large history
HISTSIZE=89999
# shellcheck disable=SC2034
SAVEHIST=80000
## History command configuration
setopt extended_history # record timestamp of command in HISTFILE
# delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_expire_dups_first
setopt hist_ignore_dups # Don't add duplicate entries
setopt hist_ignore_space # ignore commands that start with space
# show command with history expansion to user before running it
setopt hist_verify
setopt inc_append_history # add commands to HISTFILE in order of execution
setopt share_history # share command history data
setopt hist_find_no_dups # don't display duplicates in reverse search
setopt hist_reduce_blanks # remove superfluous blanks
unsetopt correct_all # Don't autocorrect when thefuck does it better.
setopt extended_glob # Muh globbing
setopt equals # use "=" to point to the path of an executable
setopt prompt_subst # Expansion
setopt interactivecomments # Comments in the interactive shell
setopt auto_continue # Send CONT signal automatically when disowning jobs
setopt auto_param_slash # implicit "cd" if the command is a path
# pushd stuff
setopt pushd_ignore_dups
export DIRSTACKSIZE=20
setopt auto_pushd

# Completion prefs
# Completion initialization happens asynchrously when loading plugins.
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' max-errors 3 numeric

# keybinds and functions
# z.lua stuff
function _z() {
	_zlua "$@";
}
export _ZL_MATCH_MODE=1
export _ZL_ECHO=0 # my prompt shows the pwd
export _ZL_NO_CHECK=1 # unmounting and re-mounting drives shouldn't mess up history
# bind C-Z to "fg", so the same keybind suspends and resumes.
#
function fancy_ctrl_z() {
	if [[ $#BUFFER -eq 0 ]]; then
		export BUFFER='fg'
		zle accept-line
	else
		zle push-input
		zle clear-screen
	fi
}
bindkey ' ' magic-space # history expansion
zle -N fancy_ctrl_z
bindkey '^Z' fancy_ctrl_z
autoload edit-command-line

# vi-mode: open command in $EDITOR
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# copy the active line from the command line buffer
copybuffer () {
	printf "%s" "$BUFFER" | wl-copy -n
}
zle -N copybuffer
bindkey "^O" copybuffer

# Print previous command with Alt-N, where N is the number of arguments
bindkey -s '\e1' "!:0 \t"
bindkey -s '\e2' "!:0-1 \t"
bindkey -s '\e3' "!:0-2 \t"
bindkey -s '\e4' "!:0-3 \t"
bindkey -s '\e5' "!:0-4 \t"
bindkey -s '\e`' "!:0- \t"     # all but the last word

# automatically escape pasted URLs
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
# autoload -Uz url-quote-magic
# zle -N self-insert url-quote-magic

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
# reload the zsh session. From OMZ:plugins/zsh_reload
zreload() {
	local cache="$ZSH_CACHE_DIR"
	autoload -U compinit zrecompile
	compinit -i -d "$cache/zcomp-$HOST"

	for f in ${ZDOTDIR:-~}/.zshrc "$cache/zcomp-$HOST"; do
		zrecompile -p $f && command rm -f $f.zwc.old
	done

	# Use $SHELL if available; remove leading dash if login shell
	[[ -n "$SHELL" ]] && exec ${SHELL#-} || exec zsh
}

# add some items to bash-insulter
custom_insults=(
	"Nani?!"
)
# increase the probability of my custom additions showing by duplicating them
custom_insults=("${custom_insults[@]}" "${custom_insults[@]}")
custom_insults=("${custom_insults[@]}" "${custom_insults[@]}")
export CMD_NOT_FOUND_MSGS_APPEND=("${custom_insults[@]}" "${custom_insults[@]}")

SHELL_COMMON="$HOME/.config/shell_common"
# source the theme
# shellcheck source=/dev/null
. "$SHELL_COMMON/zsh/powerlevel10k.zsh"
# source the plugins and start completions/autosuggestions.
# shellcheck source=.config/shell_common/zsh/zinit.zsh
export IN_ZINIT=1
. "$SHELL_COMMON/zsh/zinit.zsh"
