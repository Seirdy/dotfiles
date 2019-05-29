# I use zplugin for plugins
module_path+=( "$HOME/.zplugin/mod-bin/zmodules/Src" )
# shellcheck source=/dev/null
. "$HOME/.zplugin/bin/zplugin.zsh"

# My fancy prompt doesn't work on the standard Linux console.
if [ "$TERM" != 'linux' ]; then
	zplugin ice lucid
	zplugin load romkatv/powerlevel10k
	# zplugin load bhilburn/powerlevel9k
fi

zplugin ice wait'0' lucid
zplugin light shyiko/commacd

zplugin ice wait'0' as'program' pick'rmtrash' lucid
zplugin light PhrozenByte/rmtrash

# git-open has a manpage that I want in my MANPATH
zplugin ice wait'0' atclone"cp git-open.1.md $HOME/.local/man/man1/git-open.1" as'command' atpull'%atclone' lucid
zplugin light paulirish/git-open

zplugin ice blockf wait'0' atload'_zsh_autosuggest_start' lucid
zplugin load zsh-users/zsh-autosuggestions

# fzf-related plugins
zplugin ice wait'0' from'gh-r' lucid
zplugin load skywind3000/z.lua

zplugin ice wait'0' pick'fzf-finder.plugin.zsh' lucid
zplugin light leophys/zsh-plugin-fzf-finder

zplugin ice wait'0' pick'forgit.plugin.zsh' lucid
zplugin light wfxr/forgit

zplugin ice wait'0' pick'key-bindings.zsh' silent
zplugin light %HOME/Executables/fzf/shell

zplugin ice wait'0' pick'autopair.zsh' lucid
zplugin light hlissner/zsh-autopair

# Creates "thefuck" alias without slowing down startup
zplugin ice wait'1' lucid
zplugin light laggardkernel/thefuck

zplugin ice wait'0' atclone"cp hr.1 $HOME/.local/man/man1" as'command' atpull'%atclone' lucid
zplugin light LuRsT/hr

finish_setup() {
	zpcompinit
	zpcdreplay
}

zplugin ice blockf wait"0" as"completion" atload'finish_setup' silent
zplugin light zsh-users/zsh-completions
zplugin light srijanshetty/zsh-pip-completion
zplugin light zdharma/fast-synax-highlighting
zplugin light %HOME/.config/shell_common/kitty_completions
