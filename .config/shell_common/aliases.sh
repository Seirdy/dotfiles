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
alias llla='lll -a'
alias sl='sl | lolcat'

# wl-clipboard aliases
alias wlc='wl-copy -n'
alias wlcv='wl-copy -n && wl-paste' # copies to stdin and then displays it anyway
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
alias ytdl-720="ytdl -f 'best[height<1080]'"
alias ytdl-crs="ytdl-720 --ignore-config --add-metadata --console-title --external-downloader aria2c --sub-format=ass --sub-lang=enUS --write-sub -k --yes-playlist --socket-timeout=20 -R 20"
alias termbin='nc termbin.com 9999' # pastebin
alias dnfs='dnf search'
alias sdrem='sudo dnf remove'
alias sdins='sudo dnf install'
alias stb='sudo tlp bat'
alias rmm='rmtrash'
alias rmhtm='rm *.html' # pandoc artifacts and stuff
alias rgi='rg -i'
alias rgv='rg -v'
alias rgvi='rg -vi'
alias vim='vim -u NONE'
alias wcl='wc -l'
alias psave='pockyt put -i'
alias :q='exit' # muh vim habits
alias c='calc -p'
alias p='$PAGER'
alias fuck!='fuck --yeah' # auto-correct previous command
alias cmdv='command -v'
alias settmp='redshift -O'
alias resettmp='redshift -x'
alias dsks='diskus --size-format=binary'
alias moshlap='mosh rkumar@rkumarlappie /home/rkumar/.local/bin/tmux'
alias moshdesk='mosh rkumar@rkumar-dekstop /home/rkumar/.local/bin/tmux'
# curl
alias wtfismyip='curl https://ipv4.icanhazip.com; curl https://ipv6.icanhazip.com'
# check that tor works
alias wtfismyip-tor='curl-tor https://ipv4.icanhazip.com; curl-tor https://ipv6.icanhazip.com'
alias clbin='curl-tor --progress -F "clbin=<-" https://clbin.com'
alias 0x0='curl-tor --progress -F"file=<-" https://0x0.st'
# compiler conveniences
alias gccv='gcc -pedantic -Wall'
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
alias flatpak='flatpak --user'
alias ddgr='ddgr -x'
alias newsboat='echo -ne "\033]0;newsboat\007" && newsboat'
alias glances='glances --disable-webui --disable-bg --disable-check-update'

# mpd stuff
# query sticker for current track
alias mpc-sticker='mpc sticker "$(mpc status -f "%file%" | sed 1q)" '
# show rating for current track
alias show-rating='mpc-sticker get rating'
# show normal info for current song, along with its rating
alias now-playing='mpc status && show-rating'
# rate current track 1-10.
alias rate-track='mpc-sticker set rating'
# skip current track and show rating of the next one.
alias skip-show='mpc next && show-rating'
# shellcheck disable=SC2142 # this alias contains a function
alias rtsv='_rtsv() {
	rate-track "$1"
	{ now-playing } >> "$HOME/Documents/Notes/Top Lists/music.txt" 2>&1
}; _rtsv'

# $EDITOR aliases
alias edi='$EDITOR'
alias vdi='eval $TERMINAL $EDITOR'
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

# git aliases
alias gstat='git status'
alias gco='git commit'
alias gcoa='gco -a'
alias gcom='gco -m'
alias gcoam='gcoa -m'
alias gp='git push'
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
alias yp='yadm push origin; yadm push gh_mirror' # push dotfiles to GitLab and GitHub remotes
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
# shellcheck disable=SC2142
alias ya="yadm diff --name-status | awk '{print \$2}' | fzf --preview 'yadm dsf -- {}' | xargs -r yadm add"
# shellcheck disable=SC2142
alias yd="yadm diff --name-status | awk '{print \$2}' | fzf --preview 'yadm dsf -- {}' | xargs -r yadm diff"
alias bd='cd ..'
# bookmarks
alias cdsch='cd $HOME/Documents/Work/School'
alias cdpy='cd $HOME/Documents/programming/python'
alias cdpyc='cd $HOME/Documents/programming/python/calc/func-analysis'
alias cdnote='cd $HOME/Documents/Notes'
alias cded='cd $HOME/Documents/Work/School/ED'
alias cdla='cd $HOME/Documents/Work/School/LINALG'
alias cdcs='cd $HOME/Documents/Work/School/CS_277'
alias cdlog='cd $XDG_DATA_HOME/update-all/logs/*/.'

# kitty-specific
alias kicat='kitty +kitten icat'

# zsh-specific
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
