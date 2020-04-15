#!/bin/bash
# ^ bash shebang just so I can get shellcheck diagnostics

# I use zinit for plugins
# Except for powerlevel10k, all plugins are loaded after the prompt is displayed.
# Some of my plugins only get loaded after I have typed some characters into the
# prompt. For example, "thefuck" isn't loaded until after I type "fuc"

# shellcheck source=/dev/null
. "$ZPLG_HOME/bin/zinit.zsh"

# Common ICE modifiers

z_lucid() {
	zinit ice lucid ver'master' "$@"
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
if [ "${TERM##*-}" = '256color' ] || [ "${terminfo[colors]:?}" -gt 255 ]; then
	z_lucid depth=1
	zinit light romkatv/powerlevel10k
fi

zi0a
zinit light skywind3000/z.lua

# zi0b src'czmod.zsh'
# zinit light "$GHQ_ROOT/github.com/skywind3000/czmod"

zi0c ''
zinit light ZoeFiri/fz

zi0a
zinit light xPMo/zsh-toggle-command-prefix

zi0a
zinit light leonjza/history-here

zi0a blockf atload'_zsh_autosuggest_start'
zinit load zsh-users/zsh-autosuggestions

zi0a pick'autopair.zsh'
zinit light hlissner/zsh-autopair

# insult me if i type a command wrong
zi0a pick'src/bash.command-not-found'
zinit light hkbakke/bash-insulter

# fzf-related plugins {{{
zi0a has'fzf' pick'fzf-finder.plugin.zsh'
zinit light leophys/zsh-plugin-fzf-finder

zi0b has'fzf' pick'completion.zsh' src'key-bindings.zsh'
zinit light $GOPATH/src/github.com/junegunn/fzf/shell
# }}}

############
# Programs #
###########$

# Commands {{{

zi_program() {
	zi0a as'program' "$@"
}

zi_program has'trash' pick'rmtrash'
zinit light PhrozenByte/rmtrash

zi_program has'gpg'
zinit light dylanaraps/pash

zi_program has'jq' pick'reddio' from'gitlab'
zinit light aaronNG/reddio

zi_program pick'hURL'
zinit light 'fnord0/hURL'

# git-open has a manpage that I want in my MANPATH
zi_program has'git' atclone"cp git-open.1.md $HOME/.local/man/man1/git-open.1" atpull'%atclone'
zinit light paulirish/git-open

zi_program atclone"cp hr.1 $HOME/.local/man/man1" atpull'%atclone'
zinit light LuRsT/hr

zi_program pick'prettyping' has'ping'
zinit light denilsonsa/prettyping

zi_program has'bat' pick'src/*'
zinit light eth-p/bat-extras

zi_program has'git' pick'yadm' atclone"cp yadm.1 $HOME/.local/man/man1" atpull'%atclone'
zinit light TheLocehiliosan/yadm

zi_program has'tmux' pick'bin/xpanes'
zinit light greymd/tmux-xpanes

zi_program has'podman' pick'toolbox' src'profile.d/toolbox.sh' atclone"fd -t f -e '.1.md' -x sh -c 'go-md2man -in {} -out $HOME/.local/man/man1/\$(basename {} .md)' && mkdir -p $TOOLBOX_PROFILE_DIR && cp profile.d/toolbox.sh $TOOLBOX_PROFILE_DIR" atpull'%atclone'
zinit light containers/toolbox

zi_program has'python3' pick'imguralbum.py'
zinit light alexgisby/imgur-album-downloader

zi_program has'jq'
zinit snippet 'https://github.com/DanielG/dxld-mullvad/blob/master/am-i-mullvad.sh'

zi_program has'ueberzug' pick'stpvimg'
zinit light Seirdy/stpv
zi_program pick'stpv'
zinit light Seirdy/stpv
zi_program has'fzf' pick'fzfp'
zinit light Seirdy/stpv

zi_program has'weechat' pick'chattiest-channels'
zinit light $GHQ_ROOT/git.sr.ht/~seirdy/chattiest-channels

zi_program has'chromium-browser-privacy' pick'chrome-extension-dl'
zinit light th3lusive/chrome-extension-dl

zi_program pick'farge'
zinit light 'sdushantha/farge'

zi_program has'fzf'
zinit light denisidoro/navi

zi_program has'fzf' pick'fzf-tmux'
zinit light $GOPATH/src/github.com/junegunn/fzf/bin

zi_program pick'neofetch' atclone"cp neofetch.1 $HOME/.local/man/man1" atpull'%atclone'
zinit light dylanaraps/neofetch

zi_program has'perl' pick'exiftool'
zinit light exiftool/exiftool

zi_program has'sxiv' pick'kunst'
zinit light sdushantha/kunst

zi_program has'perl' pick'inxi'
zinit light smxi/inxi

zi_program has'grim' pick'grimshot'
zinit light $GHQ_ROOT/github.com/swaywm/sway/contrib

zi0a has'nnn'
zinit snippet $GHQ_ROOT/github.com/jarun/nnn/misc/quitcd/quitcd.bash_zsh

# }}}

# Git extensions {{{

# only used in fzf previews because delta's colors get messed up there
zi0a as'program' pick'bin/git-dsf'
zinit light zdharma/zsh-diff-so-fancy

zi0a
zinit light wfxr/emoji-cli

export FORGIT_GI_REPO_LOCAL="$XDG_DATA_HOME/forgit/gi/repos/dvcs/gitignore"

zi0c has'fzf' pick'forgit.plugin.zsh'
zinit light wfxr/forgit

zi0a as'program' has'git' pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras

zi0b as'completion' has'git-extras' blockf
zinit snippet https://github.com/tj/git-extras/blob/master/etc/git-extras-completion.zsh

# }}}

###############
# Completions #
###############

# fzf-based tab-completion. Load after all other completion plugins
z_lucid wait'1'
zinit light Aloxaf/fzf-tab

zi_completion() {
	zi0a as'completion' blockf "$@"
}

zi_completion has'tmux' pick'completion/zsh'
zinit light greymd/tmux-xpanes

zi_completion has'pip3'
zinit snippet OMZ::plugins/pip/_pip

zi_completion has'pylint'
zinit snippet OMZ::plugins/pylint/_pylint

zi_completion has'cargo'
zinit snippet OMZ::plugins/cargo/_cargo

zi_completion has'rustc'
zinit snippet OMZ::plugins/rust/_rust

zi_completion has'docker'
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zi_completion has'rg'
zinit snippet https://github.com/BurntSushi/ripgrep/blob/master/complete/_rg

zi_completion has'yadm' mv'yadm.zsh_completion -> _yadm'
zinit snippet https://github.com/TheLocehiliosan/yadm/blob/master/completion/yadm.zsh_completion

zi_completion has'tldr' mv'zsh_tealdeer -> _tldr'
zinit snippet https://github.com/dbrgn/tealdeer/blob/master/zsh_tealdeer

zi_completion has'pandoc'
zinit light srijanshetty/zsh-pandoc-completion

zi_completion has'fd'
zinit snippet OMZ::plugins/fd/_fd

zi_completion has'exa' mv'completions.zsh -> _exa'
zinit snippet https://github.com/ogham/exa/blob/master/contrib/completions.zsh

zi_completion has'cht.sh'
zinit snippet $XDG_CONFIG_HOME/shell_common/zsh/_cht.sh

zi_completion has'buku'
zinit snippet https://github.com/jarun/Buku/blob/master/auto-completion/zsh/_buku

zi_completion has'hub' mv'hub.zsh_completion -> _hub'
zinit snippet $GOPATH/src/github.com/github/hub/etc/hub.zsh_completion

zi_completion has'youtube-dl' mv'youtube-dl.zsh -> _youtube-dl'
zinit snippet $GHQ_ROOT/github.com/ytdl-org/youtube-dl/youtube-dl.zsh

zi_completion has'podman'
zinit snippet $GOPATH/src/github.com/containers/libpod/completions/zsh/_podman

zi_completion has'mpv'
zinit snippet $GHQ_ROOT/github.com/mpv-player/mpv-build/mpv/etc/_mpv.zsh

zi_completion has'se'
zinit snippet $PIPX_HOME/venvs/standardebooks/lib/python3.*/site-packages/se/completions/zsh/_se

zi_completion has'alacritty'
zinit snippet $GHQ_ROOT/github.com/alacritty/alacritty/extra/completions/_alacritty

zi_completion has'wl-copy'
zinit snippet $GHQ_ROOT/github.com/bugaevc/wl-clipboard/completions/zsh/_wl-copy
zi_completion has'wl-paste'
zinit snippet $GHQ_ROOT/github.com/bugaevc/wl-clipboard/completions/zsh/_wl-paste

if [ "$MACHINE" = 'Linux' ]; then

	zi_completion has'flatpak'
	zinit light "$GHQ_ROOT/github.com/flatpak/flatpak/completion/_flatpak"

elif [ "$MACHINE" = 'Darwin' ]; then

	zi_completion has'brew'
	zinit snippet https://github.com/Homebrew/brew/tree/master/completions/zsh/_brew

	zi_completion has'brew'
	zinit snippet https://github.com/Homebrew/brew/tree/master/completions/zsh/_brew_cask

fi

zi_completion has'rclone'
zinit light "$XDG_DATA_HOME/zsh/site-functions/_rclone"

zi0b as'completion'
zinit light zsh-users/zsh-completions

zi_completion pick'src/go' src'src/zsh'
zinit light zchee/zsh-completions

# the following will run after everything else happens
finish_setup() {
	# command -v conda >/dev/null && alias condaify='eval "$(conda shell.zsh hook 2>/dev/null)"'
	# dircolors: commented out cuz it's useless with fzf-tab, fz, and z.lua
	# eval "$(dircolors)"
	# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
	# give less pretty colors
	# shellcheck source=../../less/less_termcap.sh
	. "$XDG_CONFIG_HOME/less/less_termcap.sh"
	. "$XDG_CONFIG_HOME/lf/lf_icons.sh"
	# aliases
	SHELL_COMMON="$HOME/.config/shell_common"
	# shellcheck source=/home/.config/shell_common/aliases.sh
	. "$SHELL_COMMON/aliases.sh"
	# shellcheck source=/home/.config/shell_common/aliases_private.sh
	. "$SHELL_COMMON/aliases_private.sh" # Not committing private info
	# shellcheck source=/home/.config/shell_common/functions.sh
	. "$SHELL_COMMON/functions.sh"
	# shellcheck source=/dev/null
	. "$XDG_CONFIG_HOME/broot/launcher/bash/br"
	command -v thefuck >/dev/null && eval "$(thefuck --alias)"
	command -v kitty >/dev/null && kitty + complete setup zsh | source /dev/stdin
	GPG_TTY="$(tty)" && export GPG_TTY
	[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
	# yadm equivalent of forgit commands
	where forgit::diff | sed -e 's/git /yadm /g' -e 's/forgit::diff/yd/' | source /dev/stdin
	where yd | sed -e 's/ --bind.*$//' -e 's/^yd /_ya /' | sd ' fzf$' " fzf | sd '...  ' '/home/rkumar/' | xargs yadm add" | source /dev/stdin
	function ya() {
		yadm add "$(_ya | awk '{print $2}')"
	}
}

zi0c atload'finish_setup' atinit'zpcompinit; zpcdreplay'
zinit light zdharma/fast-syntax-highlighting
