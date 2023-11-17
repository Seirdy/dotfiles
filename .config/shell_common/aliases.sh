#!/usr/bin/env dash
# Jesus christ this is over 100 aliases

# undollar
alias \$=''

# changing my habits
# alias exiftool='echo "use mat2 instead"'

alias ls='ls --color=auto'
ls_cmd=exa
if command -v eza >/dev/null; then
	ls_cmd=eza
fi
alias exa-fancy="$ls_cmd -h --icons --group-directories-first --color=always" # kept for legacy reasons
alias l="$ls_cmd -h --icons --group-directories-first --color=always"
alias ll='l -l --time-style=long-iso'              # Better output than ls -l
alias lll='l -l --time-style=full-iso -s modified' # Show full timestamp
alias la='l -a'
alias lla='ll -a'
alias lls='ll -s size'
alias llas='lla -s size'
alias llla='lll -a'

# misspellings
alias sl='sl | lolcat'
alias httop='htop'
alias htopu='htop -u "$USER"'

# wl-clipboard aliases
alias wlc='wl-copy -n -t text/plain'
alias yankit='yank-cli -- wl-copy -n -t text/plain'
alias recopy='wl-paste -n | wl-copy -n' # good for stripping newlines I guess
alias dlpaste='aria2c "$(wl-paste -n)"'
alias dlopaste='dl-open "$(wl-paste -n)"'
alias broken-link='wl-paste -n | sd "\n" "" | url-picker' # line breaks in links
alias wlpn='wl-paste -t text/plain -n'

# basic shorthands
alias pcat='pee cat' # make `pee` from moreutils send to stdout like tee
alias a2c='aria2c'   # fast aria2c downloading
alias ytdl='yt-dlp'
# ytdl-sm: for my laptop which has mediocre hardware accel, esp. for vp8/vp9
alias ytdl-sm="ytdl -f 'bestvideo[height<=1080][vcodec^=avc1]+bestaudio[ext=m4a]/bestvideo[height<=1080]+bestaudio/bestvideo+bestaudio/best'"
# anime4k scales up 720p best
alias ytdl-720="ytdl -f 'bestvideo[height<1080]+bestaudio/best[height<1080]'"
# for crunchyroll, which I use for just "trying out" a show before I decide to actually watch it
alias ytdl-crs='ytdl-720 --ignore-config --add-metadata --console-title --external-downloader aria2c --sub-format=ass --sub-lang=enUS --write-sub -k --yes-playlist --socket-timeout=20 -R 20'
alias ffmpeg-copy='ffmpeg -c copy'
alias chafa-best='chafa --symbols all-braille-extra --zoom -w 9 -c full --color-space din99d'
alias cwebp-max='cwebp -lossless -m 6 -z 9 -q 100'
alias dnfinf='dnf info -C --forcearch x86_64'
alias dnfs='dnf search'
alias sdrem='sudo dnf remove'
alias sdins='sudo dnf install'
# alias dnfup='sudo dnf --setopt=install_weak_deps=False --setopt=max_parallel_downloads=15 upgrade --refresh --allowerasing'
alias stb='sudo tlp bat'
alias rmm='rmtrash'
alias rmhtm='rm *.html' # pandoc artifacts and stuff
alias tootn='toot notifications'
alias tootnr='toot notifications -r'
alias tootnc='toot notifications --clear'
alias tootp='toot post -l en -t text/markdown'
# curl follow redirect
alias curll='curl -SL'
alias curltl='curl-tor -L'
alias curls='curl --proto "=https" --proto-default https'
alias curlsl='curl --proto "=https" --proto-default https -sSL'
alias curlslc='curl --proto "=https" --proto-default https -sSL --compressed'
alias curlslcs='curl --proto "=https" --proto-default https -sSL --tlsv1.3 --compressed'

# ideally everything is HTTP/2+, compressed, TLSv1.3+.
alias ccurl='curl --proto "=https" --proto-default https --http2 -sSL --tlsv1.3 --compressed --cert-status'
# xh is like httpie, written in rust
alias xxh='xh --https --http-version 2 --ssl tls1.3 -FS'
alias xxhh='xh --https --http-version 2 --ssl tls1.3 -FS --headers'

# -v, -i, -z, and -F are my most commonly-used rg options.
alias rgi='rg -i'
alias rgv='rg -v'
alias rgiv='rg -iv'

alias rgu='rg -u'
alias rguv='rg -uv'
alias rgui='rg -uvi'
alias rguiv='rg -uiv'
# search everything ripgrep can; anything more than this calls for ripgrep-all
alias rguu='rg -zuuu'
# normal-ass search. just find all instances of this string. don't be clever.
# might crash with big binary files
alias rguf='rg -auuuF'

alias rgz='rg -z'
alias rgzi='rg -zi'
alias rgzv='rg -zv'
alias rgziv='rg -zvi'

alias vim='vim -u NONE'
alias wcl='wc -l'
alias psave='pockyt put -i'
alias :q='exit' # muh vim habits
alias c='calc -pm0'
alias je='julia -e'
# shellcheck disable=SC2154
alias p='pash'
alias pashc='PASH_CLIP="wl-copy -n" PASH_TIMEOUT=4 pash c' # chromium doesn't like "wl-copy -o"
#alias fuck!='fuck --yeah' # auto-correct previous command
alias cmdv='command -v'
alias settmp='redshift -O'
alias resettmp='redshift -x'
alias dsks='diskus --size-format=binary'
alias rsyncap='rsync -auP'
alias rsyncapz='rsync -azuP'
alias rsyncapzst='rsync -azuP --zc=zstd --compress-level=6'
# "serveit dir" just serves the dir over http on 8080
alias serveit='busybox httpd -fvp 8080 -h'
alias moshlap='mosh rkumar@rkumarlappie /home/rkumar/.local/bin/tmux'
alias moshdesk='mosh rkumar@rkumar-dekstop /home/rkumar/.local/bin/tmux'
# curl
alias wtfismyip='ccurl -A "" -4 https://seirdy.one/ip; echo; ccurl -A "" -6 https://seirdy.one/ip; echo'
# check that tor works
alias wtfismyip-tor='curl-tor -A "" -s4 https://seirdy.one/ip; echo; curl-tor -A "" -s6 https://seirdy.one/ip; echo'
# pastebin/file-upload stuff
alias clbincp='clbin | wlcv'
alias 0x0cp='0x0 | wlcv'
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
# alias loffcon='flatpak run org.libreoffice.LibreOffice --convert-to'
alias pdfify='loffcon pdf'
alias nvimup='nvim +PlugInstall +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qa'
alias nvimclean='nvim +PlugClean'
alias rnvim='nvim +"set secure"' # like rvim
# shellcheck disable=SC2142
alias localhosts='ip n | grep REACHABLE | awk "{ print \$1 }" | xargs -n1 host | grep -v "not found"'
alias battstat="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E 'time to (empty|full)|percentage' | sd '.*:\s*' ''"
alias emoj="emoji-fzf preview | fzf --preview 'emoji-fzf get --name {1}' | cut -d \" \" -f 1 | emoji-fzf get"
alias emoj-cp='emoj | wlc'
alias tarlz='tar -I "lzip --best" -cvf'
alias count-uniq='sort | uniq -c | sort -nr'
# nnn-based ncdu alternative
alias nnncdu='n -dHTd'
# Aliases that change existing commands
alias ffprobe='ffprobe -hide_banner'
alias tuir='LESS="-x 2 -ir" tuir --enable-media'
alias sub='tuir -s'
alias ddgr='ddgr -x'
alias newsboat='echo -ne "\033]0;newsboat\007" && newsboat'
alias glances='glances --disable-webui --disable-bg --disable-check-update'
alias amfora='TERM=foot amfora'
alias chtsh='cht.sh --auto' # prefer offline cheat.sh

# mpd stuff moved to dedicated repo
alias rate='rate-track'

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
alias mpvah='mpv --profile=anime-hq-1080'

# git aliases
alias gstat='git status'
alias gco='git commit'
alias gcoa='gco -a'
alias gcom='gco -m'
alias gcoam='gcoa -m'
alias gp='git pushall'
alias gpn='git pushall && git pushall-notes'
alias gpp="printf 'pushall-force\npushall-notes' | xargs -P0 -n1 git"
alias gpo='gp origin'
alias gpom='gpo master'
alias gpnc='git push -o skip-ci origin'
alias gpncm='git push -o skip-ci origin master'
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
alias cdnote='cd $HOME/Documents/Notes'
alias cded='cd $HOME/Documents/Work/School/ED'
alias cdla='cd $HOME/Documents/Work/School/LINALG'
alias cdcs='cd $HOME/Documents/Work/School/CS_277'
# shellcheck disable=SC2154
alias cdlog='cd $XDG_DATA_HOME/update-all/logs/*/'
# like cdg function in functions.sh but for $GOPATH
# shellcheck disable=SC2154
alias cdgo='GHQ_ROOT=$GOPATH/src cdg'

# development
alias pcrun='pre-commit run'
alias poetrun='poetry run'               # for python projects
alias ppcrun='poetry run pre-commit run' # yodawg.jpg
alias ppcall='poetry run pre-commit run --all-files'

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
fi
