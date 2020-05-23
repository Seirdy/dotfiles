#!/usr/bin/env dash
# Jesus christ this is over 100 aliases

# undollar
alias \$=''

alias exa-fancy='exa -h --icons --group-directories-first --color=always'
alias l='lsd --group-dirs first --color always --icon always --icon-theme fancy'
alias ll='exa-fancy -l --time-style=long-iso'              # Better output than ls -l
alias lll='exa-fancy -l --time-style=full-iso -s modified' # Show full timestamp
alias la='l -A'
alias lla='ll -a'
alias lls='ll -s size'
alias llas='lla -s size'
alias llla='lll -a'
alias sl='sl | lolcat'

# wl-clipboard aliases
alias wlc='wl-copy -n'
alias wlcv='wl-copy -n -t text/plain && wl-paste' # copies to stdin and then displays it anyway
alias yankit='yank-cli -- wl-copy -n'
alias recopy='wl-paste -n | wl-copy -n' # good for stripping newlines I guess
alias dlpaste='aria2c "$(wl-paste -n)"'
alias dlopaste='dl-open "$(wl-paste -n)"'
alias broken-link='wl-paste -n | sd "\n" "" | url-picker' # line breaks in links

# basic shorthands
alias a2c='aria2c' # fast aria2c downloading
alias ytdl='youtube-dl'
# ytdl-sm: for my laptop which has mediocre hardware accel, esp. for vp8/vp9
alias ytdl-sm="ytdl -f 'bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/bestvideo[height<=1080]+bestaudio/best'"
# anime4k scales up 720p best
alias ytdl-720="ytdl -f 'bestvideo[height<1080]+bestaudio/best[height<1080]'"
alias ytdl-crs='ytdl-720 --ignore-config --add-metadata --console-title --external-downloader aria2c --sub-format=ass --sub-lang=enUS --write-sub -k --yes-playlist --socket-timeout=20 -R 20'
alias ffmpeg-copy='ffmpeg -c:v copy -c:a copy'
alias chafa-best='chafa --symbols all-braille-extra --zoom -w 9 -c full --color-space din99d'
alias cwebp-max='cwebp -lossless -m 6 -z 9 -q 100'
alias tb='nc termbin.com 9999 | tr -d "\n"' # pastebin
alias dnfs='dnf search'
alias sdrem='sudo dnf remove'
alias sdins='sudo dnf install'
alias stb='sudo tlp bat'
alias rmm='rmtrash'
alias rmhtm='rm *.html' # pandoc artifacts and stuff
# curl follow redirect
alias curll='curl -L'
alias curltl='curl-tor -L'
alias rgi='rg -i'
alias rgv='rg -v'
alias rgvi='rg -vi'
alias vim='vim -u NONE'
alias wcl='wc -l'
alias psave='pockyt put -i'
alias :q='exit' # muh vim habits
alias c='calc -p'
# shellcheck disable=SC2154
alias p='pash'
alias fuck!='fuck --yeah' # auto-correct previous command
alias cmdv='command -v'
alias settmp='redshift -O'
alias resettmp='redshift -x'
alias dsks='diskus --size-format=binary'
alias rsyncap='rsync -auP'
alias rsyncapz='rsync -azuP'
alias moshlap='mosh rkumar@rkumarlappie /home/rkumar/.local/bin/tmux'
alias moshdesk='mosh rkumar@rkumar-dekstop /home/rkumar/.local/bin/tmux'
# curl
alias wtfismyip='curl https://ipv4.icanhazip.com; curl https://ipv6.icanhazip.com'
# check that tor works
alias wtfismyip-tor='curl-tor https://ipv4.icanhazip.com; curl-tor https://ipv6.icanhazip.com'
# pastebin/file-upload stuff
alias clbincp='clbin | wlcv'
alias 0x0cp='0x0 | wlcv'
alias tbcp='tb | wlcv'
# mirror the URL in the clipboard to 0x0.st
alias mirror0x0='curl "$(wl-paste -n)" >/tmp/img && upl /tmp/img'
# mirror to 0x0.st and copy the 0x0.st URL
alias mirror0x0cp='curl "$(wl-paste -n)" >/tmp/img && upl /tmp/img | wlcv'
# mirror to 0x0.st, copy the 0x0.st URL, and view the result ot make sure it worked
alias mirror0x0check='mirror0x0cp && imv-url "$(wl-paste)"' # see ~/.local/bin/imv-url
# compiler conveniences
alias gccv='gcc -pedantic -Wall'
alias shchk='shellcheck'
alias shchkv='shellcheck -xa -o all -e SC2250' # more strict shellcheck
alias gorun='go run .'
alias gobld='go build'
# flatpak app aliases to replicate non-flatpak CLI functionality
command -v ebook-viewer >/dev/null || alias ebook-convert='flatpak run --command=ebook-convert com.calibre_ebook.calibre'
alias loffcon='flatpak run org.libreoffice.LibreOffice --convert-to'
alias pdfify='loffcon pdf'
alias nvimup='nvim +PlugInstall +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qa'
alias nvimclean='nvim +PlugClean'
# shellcheck disable=SC2142
alias localhosts='ip n | grep REACHABLE | awk "{ print \$1 }" | xargs -n1 host | grep -v "not found"'
alias battstat="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E 'time to (empty|full)|percentage' | sd '.*:\s*' ''"
alias emoj="emoji-fzf preview | fzf --preview 'emoji-fzf get --name {1}' | cut -d \" \" -f 1 | emoji-fzf get"
alias emoj-cp='emoj | wl-copy'
alias tarlz='tar -I "lzip --best" -cvf'
# Aliases that change existing commands
alias tuir='LESS="-x 2 -ir" tuir --enable-media'
alias sub='tuir -s'
alias ddgr='ddgr -x'
alias newsboat='echo -ne "\033]0;newsboat\007" && newsboat'
alias glances='glances --disable-webui --disable-bg --disable-check-update'
alias chtsh='cht.sh --auto' # prefer offline cheat.sh

# mpd stuff moved to dedicated repo

# $EDITOR aliases
# shellcheck disable=SC2154
alias edi='$EDITOR'
alias vdi='terminal $EDITOR'
# shellcheck disable=SC2154
alias aliasrc='edi $XDG_CONFIG_HOME/shell_common/aliases.sh'
alias funcrc='edi $XDG_CONFIG_HOME/shell_common/functions.sh'
alias zshrc='edi $HOME/.zshrc'
alias zinitrc='edi $XDG_CONFIG_HOME/shell_common/zsh/zinit.zsh'
alias tmuxrc='edi $XDG_CONFIG_HOME/tmux/tmux.conf'
alias nvimrc='edi $XDG_CONFIG_HOME/nvim/init.vim'
alias startuprc='edi $HOME/startup.sh'
alias rssrc='edi $XDG_CONFIG_HOME/newsboat/urls'
alias newsboatrc='edi $XDG_CONFIG_HOME/newsboat/config'
alias swayrc='edi $XDG_CONFIG_HOME/sway/config_master'
alias i3statrc='edi $XDG_CONFIG_HOME/sway/status.toml'
alias tridactylrc='edi $XDG_CONFIG_HOME/tridactyl/tridactylrc'
alias kittyrc='edi $XDG_CONFIG_HOME/kitty/kitty_master.conf'
alias alacrittyrc='edi $XDG_CONFIG_HOME/alacritty/alacritty_master.yml'
alias mpvrc='edi $XDG_CONFIG_HOME/mpv/mpv.conf'

# mpv aliases
alias mpva='mpv --profile=anime'
alias mpvah='mpv --profile=anime-hq'

# git aliases
alias gstat='git status'
alias gco='git commit'
alias gcoa='gco -a'
alias gcom='gco -m'
alias gcoam='gcoa -m'
alias gp='git pushall'
alias gpp='git push origin; git push gh_mirror' # push to GitLab and GitHub remotes
alias gpo='gp origin'
alias gpom='gpo master'
alias gm='git merge'
alias git-url='git ls-remote --get-url'
alias gcl='git clone'
alias gclr='gcl --recursive'
alias gpull='git pull; git submodule update --init --recursive --force --remote'
alias grst='git reset'
alias gadd='git add'
alias gdd='git diff'
alias gds='gdd --staged'
alias gopen='git open'
# yadm aliases
alias ystat='yadm status'
alias yco='yadm commit -S'
alias ycoa='yco -a'
alias ycom='yco -m'
alias ycoam='ycoa -m'
alias yp='yadm pushall' # push dotfiles to GitLab and GitHub remotes
alias ypo='yp origin'
alias ypom='ypo master'
alias ym='yadm merge'
alias yit-url='yadm ls-remote --get-url'
alias ycl='yadm clone'
alias yclr='ycl --recursive'
alias ypull='yadm pull; yadm submodule update --init --recursive --force --remote'
alias yrst='yadm reset'
alias yadd='yadm add'
alias ydd='yadm diff'
alias yds='ydd --staged'
alias yopen='yadm open'
alias yurl='sed "s#/home/rkumar#https://git.sr.ht/~seirdy/dotfiles/tree/master#"' # URL to a file in my dotfile repo
alias yurlc='yurl | wlcv'
# shellcheck disable=SC2142
alias bd='cd ..'
# bookmarks
alias cdsch='cd $HOME/Documents/Work/School'
alias cdpy='cd $HOME/Documents/programming/python'
alias cdpyc='cd $HOME/Documents/programming/python/calc/func-analysis'
alias cdnote='cd $HOME/Documents/Notes'
alias cded='cd $HOME/Documents/Work/School/ED'
alias cdla='cd $HOME/Documents/Work/School/LINALG'
alias cdcs='cd $HOME/Documents/Work/School/CS_277'
# shellcheck disable=SC2154
alias cdlog='cd $XDG_DATA_HOME/update-all/logs/*/.'
# like cdg function in functions.sh but for $GOPATH
# shellcheck disable=SC2154
alias cdgo='GHQ_ROOT=$GOPATH/src cdg'

# pash
alias fashcp='fash copy'
# shellcheck disable=SC2154
alias encryptit='gpg -r $PASH_KEYID --symmetric --cipher-algo=AES256 --compress-algo none --encrypt'

# kitty-specific
alias kicat='kitty +kitten icat'

# zsh-specific
# shellcheck disable=SC2154
if [ -n "$ZSH_VERSION" ]; then
	alias -g isotime='$(date -u -Iseconds)'
	timefile() {
		printf '%s%s' "$(date -Iseconds)" ".$1"
	}
	alias -g nnote='$(timefile md)'
	alias -g todaynote='"$(date -u +%Y-%m-%d)"*'
	alias -g detch='&>/dev/null 2>/dev/null & disown'
	alias -g pagit='| $PAGER'
	alias -g w3m-htm='| w3m -T text/html'
	if command -v lolcat >/dev/null; then
		alias -g rofl='| lolcat'
	fi
	alias zpstudy='zpmod source-study | grep -v "[0-5] ms" | sort -bgr'
	alias -g 'wlp'='"$(wl-paste -n)"'
	unalias zf
	alias zf="FZF_DEFAULT_OPTS=\"$FZF_DEFAULT_OPTS --preview='lsd --group-dirs first --color always --icon always --icon-theme fancy {2}'\" z -I"
fi
