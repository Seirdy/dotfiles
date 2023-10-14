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

# zi0a
# zinit light Tarrasch/zsh-autoenv

zi0c has'fzf' ''
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
zinit light $GHQ_ROOT/github.com/junegunn/fzf/shell
# }}}

############
# Programs #
###########$

# Commands {{{

zi_program() {
	zi0a as'program' "$@"
}

zi_program has'gpg'
zinit light dylanaraps/pash

zi_program has'jq' pick'reddio' from'gitlab'
zinit light aaronNG/reddio

zi_program pick'hURL'
zinit light fnord0/hURL

zi_program has'mogrify'
zinit light hackerb9/lsix

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

# zi_program has'podman' pick'toolbox' src'profile.d/toolbox.sh' atclone"fd -t f -e '.1.md' -x sh -c 'go-md2man -in {} -out $HOME/.local/man/man1/\$(basename {} .md)' && mkdir -p $TOOLBOX_PROFILE_DIR && cp profile.d/toolbox.sh $TOOLBOX_PROFILE_DIR" atpull'%atclone'
# zinit light containers/toolbox

zi_program has'python3' pick'imguralbum.py'
zinit light alexgisby/imgur-album-downloader

zi_program has'jq'
zinit snippet 'https://github.com/DanielG/dxld-mullvad/blob/master/am-i-mullvad.sh'

zi_program has'fzf' pick'fzfp'
zinit light Seirdy/stpv

zi_program has'weechat' pick'chattiest-channels'
zinit light $GHQ_ROOT/git.sr.ht/~seirdy/chattiest-channels

zi_program has'bash' pic'vimv'
zinit light thameera/vimv

# zi_program has'ueberzug' pick'stpvimg'
# zinit light Seirdy/stpv

zi_program pick'stpv'
zinit light Seirdy/stpv

if [ -n "$WAYLAND_DISPLAY" ]; then
	zi_program pick'farge'
	zinit light sdushantha/farge

	zi_program has'imv' pick'kunst'
	zinit light $GHQ_ROOT/git.sr.ht/~seirdy/kunst

	zi_program has'grim' pick'grimshot'
	zinit light $GHQ_ROOT/github.com/swaywm/sway/contrib

fi

zi_program has'fzf'
zinit light denisidoro/navi

zi_program has'fzf' pick'fzf-tmux'
zinit light $GHQ_ROOT/github.com/junegunn/fzf/bin

zi_program pick'neofetch' atclone"cp neofetch.1 $HOME/.local/man/man1" atpull'%atclone'
zinit light dylanaraps/neofetch

if ! command -v exiftool >/dev/null; then
	zi_program has'perl' has'convert' pick'exiftool'
	zinit light exiftool/exiftool
fi

if [ -z "$SSH_CONNECTION" ]; then
	zi_program has'perl' pick'inxi'
	zinit light smxi/inxi
fi

zi0a has'nnn'
zinit snippet $GHQ_ROOT/github.com/jarun/nnn/misc/quitcd/quitcd.bash_zsh

# }}}

# Git extensions {{{

# only used in fzf previews because delta's colors get messed up there
zi0a has'perl' as'program' pick'bin/git-dsf'
zinit light zdharma/zsh-diff-so-fancy

zi0a
zinit light wfxr/emoji-cli

export FORGIT_GI_REPO_LOCAL="$XDG_DATA_HOME/forgit/gi/repos/dvcs/gitignore"

zi0b has'fzf' pick'forgit.plugin.zsh'
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
zi0c has'fzf'
zinit light Aloxaf/fzf-tab

zi_completion() {
	zi0a as'completion' blockf "$@"
}

zi_completion has'ghq'
zinit snippet https://github.com/x-motemen/ghq/blob/master/misc/zsh/_ghq

zi_completion has'tmux' pick'completion/zsh'
zinit light greymd/tmux-xpanes

zi_completion has'cargo'
zinit snippet $RUSTUP_HOME/toolchains/nightly-x86_64-unknown-linux-gnu/share/zsh/site-functions/_cargo

zi_completion has'rustc'
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/rust/_rust

zi_completion has'yadm'
zinit snippet https://github.com/TheLocehiliosan/yadm/blob/master/completion/zsh/_yadm

zi_completion has'msync' mv'msync_complete.sh -> _msync'
zinit snippet $GHQ_ROOT/github.com/Kansattica/msync/scripts/msync_complete.sh

zi_completion has'tldr' mv'zsh_tealdeer -> _tldr'
zinit snippet https://github.com/dbrgn/tealdeer/blob/master/zsh_tealdeer

zi_completion has'yt-dlp'
zinit snippet $GHQ_ROOT/github.com/yt-dlp/yt-dlp/completions/zsh/_yt-dlp

zi_completion has'cht.sh'
zinit snippet $XDG_CONFIG_HOME/shell_common/zsh/_cht.sh

zi_completion has'buku'
zinit snippet https://github.com/jarun/Buku/blob/master/auto-completion/zsh/_buku

# zi_completion has'eza'
# zinit snippet /usr/share/zsh/site-functions/_eza

zi_completion has'mpv'
zinit snippet $GHQ_ROOT/github.com/mpv-player/mpv/etc/_mpv.zsh

zi_completion has'beet'
zinit snippet 'https://github.com/beetbox/beets/blob/master/extra/_beet'

zi0b as'completion'
zinit light zsh-users/zsh-completions

zi_completion pick'src/go' src'src/zsh'
zinit light zchee/zsh-completions

zi_completion mv'git-completion.zsh -> _git'
zinit snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh

zi_completion
zinit light $GHQ_ROOT/github.com/sunaku/dasht/etc/zsh/completions

zi_completion pick'_foot' src'footclient'
zinit light $GHQ_ROOT/codeberg.org/dnkl/foot/completions/zsh

SHELL_COMMON=$XDG_CONFIG_HOME/shell_common

zi_completion has'wormhole-william'
zinit snippet $SHELL_COMMON/zsh/completions/_wormhole-william

zi_completion has'pip'
zinit snippet $SHELL_COMMON/zsh/completions/_pip

zi_completion has'poetry'
zinit snippet $SHELL_COMMON/zsh/completions/_poetry

zi0a has'thefuck'
zinit snippet $SHELL_COMMON/zsh/thefuck/thefuck.sh

zi0b
zinit snippet $XDG_CONFIG_HOME/less/less_termcap.sh

zi0a pick'aliases.sh' multisrc'functions_ghq.sh pash.sh functions.sh aliases_private.sh'
zinit light $SHELL_COMMON

# the following will run after everything else happens
finish_setup() {
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
	zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --group-directories-first --color=always $realpath'
	zstyle ':fzf-tab:complete:man:*' fzf-preview 'man $word'
	# zstyle ':fzf-tab:*' fzf-command fzf-tmux
	zstyle ':fzf-tab:*' single-group ''
	zstyle ':fzf-tab:complete:_zlua:*' query-string input
	zstyle ':fzf-tab:complete:_fz:*' query-string input
	GPG_TTY="$(tty)" && export GPG_TTY
	[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
	# yadm equivalent of forgit commands
	where forgit::diff | sed -e 's/git /yadm /g' -e 's/forgit::diff/yd/' | source /dev/stdin
	where yd | sed -e 's/ --bind.*$//' -e 's/^yd /_ya /' | sd ' fzf$' " fzf | sd '...  ' "$HOME" | xargs yadm add" | source /dev/stdin
	function ya() {
		yadm add "$HOME/$(_ya | awk '{print $2}')"
	}
	# fzf ctrl-r widget: show timestamp of command and add syntax highlighting for preview window
	where fzf-history-widget | sed 's/fc -rl/fc -ril/' | source /dev/stdin \
		&& export FZF_CTRL_R_OPTS="--preview 'echo {1..3}; echo {4..} | bat --style=plain --language=zsh' --preview-window down:3:wrap --bind '?:toggle-preview'"
	alias z="FZF_DEFAULT_OPTS=\"$FZF_DEFAULT_OPTS --preview='eza --group-directories-first --color always -a1 --icons {2}'\" _fz"
}

zinit wait'0c' lucid light-mode for \
	atclone'print Installing system completions...; \
	zinit creinstall -q /usr/share/zsh/site-functions' \
	atload'zpcompinit; zpcdreplay; finish_setup' \
	zdharma/fast-syntax-highlighting
