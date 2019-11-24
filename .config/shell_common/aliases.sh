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

alias a2c='aria2c' # fast aria2c downloading
alias dlpaste='aria2c "$(wl-paste)"'
alias dlopaste='dl-open "$(wl-paste)"'
alias ytdl='youtube-dl'
alias ytdl-sm="ytdl -f 'bestvideo[height<=1080]+bestaudio'"
alias termbin='nc termbin.com 9999' # pastebin
alias dnfs='dnf search'
alias sdrem='sudo dnf remove'
alias sdins='sudo dnf install'
alias stb='sudo tlp bat'
alias rmm='rmtrash'
alias rmhtm='rm *.html'
alias rgi='rg -i'
alias rgv='rg -v'
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
# compiler conveniences
alias gccv='gcc -pedantic -Wall'
alias gorun='go run .'
alias gobld='go build'
# flatpak app aliases to replicate non-flatpak CLI functionality
alias ebook-convert='flatpak run --command=ebook-convert com.calibre_ebook.calibre'
alias loffcon='flatpak run org.libreoffice.LibreOffice --convert-to'
alias pdfify='loffcon pdf'
alias nvimup='nvim +PlugInstall +PlugUpdate +PlugUpgrade +CocStart +CocUpdate +qa'
alias nvimclean='nvim +PlugClean'
# shellcheck disable=SC2142
alias localhosts='ip n | grep REACHABLE | awk "{ print \$1 }" | xargs -n1 host | grep -v "not found"'
alias battstat="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | rg 'time to empty|percentage'"
alias emoj="emoji-fzf preview | fzf --preview 'emoji-fzf get --name {1}' | cut -d \" \" -f 1 | emoji-fzf get"
alias emoj-cp='emoj | wl-copy'
alias weechat-matrix='source $GHQ_ROOT/github.com/poljar/weechat-matrix/venv/bin/activate && weechat -r "/script load matrix.py; /matrix connect matrix_org"'
alias now-playing='mpc status; mpc sticker "$(mpc status -f "%file%" | sed 1q)" get rating'
# Aliases that change existing commands
alias ddgr='ddgr -x'
alias newsboat='echo -ne "\033]0;newsboat\007" && newsboat'
alias z='z -I'
alias tldr='tldr -p'
alias tuir='tuir --enable-media'
alias sub='tuir -s'
alias glances='glances --disable-webui --disable-bg --disable-check-update'
if command -v roflcat >/dev/null; then
	alias lolcat='roflcat -t'
fi

# Editing aliases
alias edi='$EDITOR'
alias vdi='eval $TERMINAL $EDITOR'
alias aliasrc='edi $XDG_CONFIG_HOME/shell_common/aliases.sh'
alias funcrc='edi $XDG_CONFIG_HOME/shell_common/functions.sh'
alias zshrc='edi $HOME/.zshrc'
alias zpluginrc='edi $XDG_CONFIG_HOME/shell_common/zsh/zplugin.zsh'
alias nvimrc='edi $XDG_CONFIG_HOME/nvim/init.vim'
alias startuprc='edi $HOME/startup.sh'
alias rssrc='edi $XDG_CONFIG_HOME/newsboat/urls'
alias newsboatrc='edi $XDG_CONFIG_HOME/newsboat/config'
alias swayrc='edi $XDG_CONFIG_HOME/sway/config'
alias i3statrc='edi $XDG_CONFIG_HOME/sway/status.toml'
alias tridactylrc='edi $XDG_CONFIG_HOME/tridactyl/tridactylrc'
alias kittyrc='edi $XDG_CONFIG_HOME/kitty/kitty_master.conf'
alias cocrc='nvim +CocConfig'

# git aliases
alias gstat='git status'
alias gco='git commit'
alias gcoa='gco -a'
alias gcom='gco -m'
alias gcoam='gcoa -m'
alias gp='git push'
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
alias yadm='yadm -Y "$XDG_CONFIG_HOME/yadm"'
alias ystat='yadm status'
alias yco='yadm commit -S'
alias ycoa='yco -a'
alias ycom='yco -m'
alias ycoam='ycoa -m'
alias yp='yadm push'
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
		printf '%s%s' "$(date -u -Iseconds)" ".$1"
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
	alias -g 'wlp'='"$(wl-paste)"'
fi
