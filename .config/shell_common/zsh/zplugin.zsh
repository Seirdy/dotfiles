# I use zplugin for plugins
# Except for powerlevel10k, all plugins are loaded after the prompt is displayed.
# Some of my plugins only get loaded after I have typed some characters into the
# prompt. For example, "thefuck" isn't loaded until after I type "fuc"

# shellcheck source=/dev/null
. "$HOME/.zplugin/bin/zplugin.zsh"

# Common ICE modifiers

zi() {
	zplugin ice lucid "$@"
}
zi0() {
	zi wait'0' "$@"
}

###########
# Plugins #
###########

# My fancy prompt doesn't work on the standard Linux console.
if [ $terminfo[colors] > 255 ]; then
	zi
	zplugin load romkatv/powerlevel10k
	# zplugin load bhilburn/powerlevel9k
fi

zi0
zplugin load skywind3000/z.lua

zi0
zplugin light zdharma/fast-syntax-highlighting

zi0
zplugin light shyiko/commacd

zi wait'[[ -n ${ZLAST_COMMANDS[(r)extr*]} ]]' as'snippet' pick'extract.sh'
zplugin light xvoland/Extract

# Creates "thefuck" alias without slowing down startup
zi wait'[[ -n ${ZLAST_COMMANDS[(r)fuc*]} ]]'
zplugin light laggardkernel/thefuck

zi0 blockf atload'_zsh_autosuggest_start'
zplugin load zsh-users/zsh-autosuggestions

zi0 pick'autopair.zsh'
zplugin light hlissner/zsh-autopair

# fzf-related plugins {{{
	zi0 has'fzf' pick'fzf-finder.plugin.zsh'
	zplugin light leophys/zsh-plugin-fzf-finder

	zi0 has'git' has'fzf' pick'forgit.plugin.zsh'
	zplugin light wfxr/forgit

	zi0 has'fzf' pick'key-bindings.zsh'
	zplugin light %HOME/Executables/fzf/shell
# }}}

############
# Programs #
###########$

# Commands {{{

	zi_program() {
		zi0 as'program' "$@"
	}

	zi_program has'trash' pick'rmtrash'
	zplugin light PhrozenByte/rmtrash

	# git-open has a manpage that I want in my MANPATH
	zi_program has'git' atclone"cp git-open.1.md $HOME/.local/man/man1/git-open.1" atpull'%atclone'
	zplugin light paulirish/git-open

	zi_program atclone"cp hr.1 $HOME/.local/man/man1" atpull'%atclone'
	zplugin light LuRsT/hr

# }}}

# Git extensions {{{

	zi_git_program() {
		zi as'program' wait'[[ -n ${ZLAST_COMMANDS[(r)git*]} ]]' "$@"
	}

	zi_git_program pick'bin/git-dsf'
	zplugin light zdharma/zsh-diff-so-fancy

	zi_git_program pick'bin/git-*' make"PREFIX=$ZPFX"
	zplugin light tj/git-extras

# }}}

###############
# Completions #
###############

finish_setup() {
	zpcompinit
	zpcdreplay
}

zi0 has'pip3' as'completion'
zplugin light srijanshetty/zsh-pip-completion

zi0 has'flatpak' as'completion'
zplugin light bilelmoussaoui/flatpak-zsh-completion

zi0 has'kitty' as'completion'
zplugin light %HOME/.config/shell_common/kitty_completions

zi0 as'completion' atload'finish_setup'
zplugin light zsh-users/zsh-completions

