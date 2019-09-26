#!/bin/bash
# I use zplugin for plugins
# Except for powerlevel10k, all plugins are loaded after the prompt is displayed.
# Some of my plugins only get loaded after I have typed some characters into the
# prompt. For example, "thefuck" isn't loaded until after I type "fuc"

# shellcheck source=/dev/null
. "$HOME/.zplugin/bin/zplugin.zsh"

# Common ICE modifiers

z_lucid() {
	zplugin ice lucid ver'master' "$@"
}
zi0a() {
	z_lucid wait'0a' "$@"
}

zi0b() {
	z_lucid wait'0b' "$@"
}

zi0c() {
	z_lucid wait'0c' "$@"
}

###########
# Plugins #
###########

# My fancy prompt needs at least 256 colors, preferably 24bit color
if [ "${terminfo[colors]:?}" -gt 255 ]; then
	z_lucid
	zplugin load romkatv/powerlevel10k
fi

zi0b proto'git'
zplugin light skywind3000/z.lua

zi0c ''
zplugin snippet https://github.com/changyuheng/fz/blob/master/fz.sh

zi0a
zplugin light zdharma/fast-syntax-highlighting

#shellcheck disable=SC2016
z_lucid wait'[[ -n ${ZLAST_COMMANDS[(r)extr*]} ]]' as'snippet' pick'extract.sh'
zplugin light xvoland/Extract

# Creates "thefuck" alias without slowing down startup
#shellcheck disable=SC2016
z_lucid wait'[[ -n ${ZLAST_COMMANDS[(r)fuc*]} ]]'
zplugin light laggardkernel/thefuck

zi0a blockf atload'_zsh_autosuggest_start'
zplugin load zsh-users/zsh-autosuggestions

zi0a pick'autopair.zsh'
zplugin light hlissner/zsh-autopair

# fzf-related plugins {{{
zi0a has'fzf' pick'fzf-finder.plugin.zsh'
zplugin light leophys/zsh-plugin-fzf-finder

zi0a has'fzf' pick'key-bindings.zsh'
zplugin light %"$GOPATH"/src/github.com/junegunn/fzf/shell
# }}}

############
# Programs #
###########$

# Commands {{{

zi_program() {
	zi0a as'program' "$@"
}

zi_program has'trash' pick'rmtrash'
zplugin light PhrozenByte/rmtrash

# git-open has a manpage that I want in my MANPATH
zi_program has'git' atclone"cp git-open.1.md $HOME/.local/man/man1/git-open.1" atpull'%atclone'
zplugin light paulirish/git-open

zi_program atclone"cp hr.1 $HOME/.local/man/man1" atpull'%atclone'
zplugin light LuRsT/hr

zi_program pick'prettyping' has'ping'
zplugin light denilsonsa/prettyping

zi_program has'bat' pick'src/*'
zplugin light https://github.com/eth-p/bat-extras

zi_program has'git' pick'yadm' atclone"cp yadm.1 $HOME/.local/man/man1" atpull'%atclone'
zplugin light TheLocehiliosan/yadm

zi_program has'podman' pick'toolbox'
zplugin light https://github.com/debarshiray/toolbox

zi_program has'jq'
zplugin snippet 'https://github.com/DanielG/dxld-mullvad/blob/master/am-i-mullvad.sh'

zi_program has'ueberzug' pick'stpvimg'
zplugin light https://github.com/Seirdy/stpv
zi_program pick'stpv'
zplugin light https://github.com/Seirdy/stpv
zi_program has'fzf' pick'fzfp'
zplugin light https://github.com/Seirdy/stpv

zi_program has'perl'
zplugin snippet https://github.com/bobrippling/perlbin/blob/master/xurls

# }}}

# Git extensions {{{

# has ICE-selector wait'0a' so it gets loaded before "forgit"
zi0a as'program' pick'bin/git-dsf'
zplugin light zdharma/zsh-diff-so-fancy

zi0a
zplugin light wfxr/emoji-cli

# has ICE-selector wait'0b' so it gets loaded after diff-so-fancy
zi0b has'fzf' pick'forgit.plugin.zsh'
zplugin light wfxr/forgit

zi0a as'program' has'git' pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zplugin light tj/git-extras

zi0b as'completion' has'git-extras' blockf
zplugin snippet "$HOME/.zplugin/plugins/tj---git-extras/etc/git-extras-completion.zsh"

# }}}

###############
# Completions #
###############

zi_completion() {
	zi0a as'completion' blockf "$@"
}

# Seems to only work on Linux and BSD
if [ "$MACHINE" != 'Darwin' ]; then
	zi0a
	zplugin snippet https://github.com/changyuheng/zsh-interactive-cd/blob/master/zsh-interactive-cd.plugin.zsh
fi

zi_completion has'pip3'
zplugin snippet OMZ::plugins/pip/_pip

zi_completion has'pylint'
zplugin snippet OMZ::plugins/pylint/_pylint

zi_completion has'cargo'
zplugin snippet OMZ::plugins/cargo/_cargo

zi_completion has'rustc'
zplugin snippet OMZ::plugins/rust/_rust

zi_completion has'docker'
zplugin snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zi_completion has'kitty'
zplugin light %HOME/.config/shell_common/kitty_completions

zi_completion has'rg'
zplugin snippet https://github.com/BurntSushi/ripgrep/blob/master/complete/_rg

zi_completion has'yadm' mv'yadm.zsh_completion -> _yadm'
zplugin snippet https://github.com/TheLocehiliosan/yadm/blob/master/completion/yadm.zsh_completion

zi_completion has'fd'
zplugin snippet OMZ::plugins/fd/_fd

zi_completion has'exa' mv'completions.zsh -> _exa'
zplugin snippet https://github.com/ogham/exa/blob/master/contrib/completions.zsh

zi_completion has'cht.sh' mv'zsh.txt -> _cht.sh'
zplugin snippet https://github.com/chubin/cheat.sh/blob/master/share/zsh.txt

zi_completion has'buku'
zplugin snippet https://github.com/jarun/Buku/blob/master/auto-completion/zsh/_buku

if [ "$MACHINE" = 'Linux' ]; then

	zi_completion has'flatpak'
	zplugin snippet https://github.com/flatpak/flatpak/blob/master/completion/_flatpak

elif [ "$MACHINE" = 'Darwin' ]; then

	zi_completion has'brew'
	zplugin snippet https://github.com/Homebrew/brew/tree/master/completions/zsh/_brew

	zi_completion has'brew'
	zplugin snippet https://github.com/Homebrew/brew/tree/master/completions/zsh/_brew_cask

fi

finish_setup() {
	zpcompinit
	zpcdreplay
	# give less pretty colors
	# shellcheck source=../../less/less_termcap.sh
	. "$XDG_CONFIG_HOME/less/less_termcap.sh"
	. "$XDG_CONFIG_HOME/lf/lf_icons.sh"
	# aliases
	SHELL_COMMON="$HOME/.config/shell_common"
	# shellcheck source=../aliases.sh
	. "$SHELL_COMMON/aliases.sh"
	# shellcheck source=../aliases_private.sh
	. "$SHELL_COMMON/aliases_private.sh" # Not committing private info
	# shellcheck source=../functions.sh
	. "$SHELL_COMMON/functions.sh"
}

zi_completion atload'finish_setup'
zplugin light zsh-users/zsh-completions
