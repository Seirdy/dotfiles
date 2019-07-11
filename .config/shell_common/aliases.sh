# aliases
alias psave='pockyt put -i'
alias :q='exit'  # muh vim habits
alias c='calc -p'

alias l='lsd --group-dirs first'  # like ls, but faster and with MOAR ICONS
alias ll='exa -lh --time-style=iso'  # Better output than ls -l
alias lll='exa -lh --time-style=full-iso -s modified'  # Show full timestamp
alias la='l -a'
alias lla='ll -a'
alias llla='lll -a'

alias rmm='rmtrash'
alias rmhtm='rm *.html'
alias rgi='rg -i'
alias rgv='rg -v'
alias vim='vim -u NONE'
alias ddgr='ddgr -x'
alias fuck!='fuck --yeah'  # auto-correct previous command

# Editing aliases
alias edi='$EDITOR'
alias vdi='$DEFTERM $EDITOR'
alias aliasrc='edi $XDG_CONFIG_HOME/shell_common/aliases.sh'
alias funcrc='edi $XDG_CONFIG_HOME/shell_common/functions.sh'
alias zshrc='edi $HOME/.zshrc'
alias zpluginrc='edi $XDG_CONFIG_HOME/shell_common/zsh/zplugin.zsh'
alias nvimrc='edi $XDG_CONFIG_HOME/nvim/init.vim'
alias startuprc='edi $HOME/startup.sh'
alias rssrc='edi $XDG_CONFIG_HOME/newsboat/urls'
alias tridactylrc='edi $XDG_CONFIG_HOME/tridactyl/tridactylrc'

# gcc with all the errors
alias gccv='gcc -pedantic -Wall'

# git aliases
alias gstat='git status'
alias gco='git commit -S'
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

alias a2c='aria2c'  # fast aria2c downloading
alias ytdl='youtube-dl'
alias ytdl-bf='ytdl --format=bestvideo+bestaudio/best'
alias ytdl-sm="youtube-dl -f 'bestvideo[height<=720]+bestaudio'"
alias sdrem='sudo dnf remove'
alias sdins='sudo dnf install'
# alias pwsv='sudo tlp bat && sudo powertop'
alias stb='sudo tlp bat'
# Calibre flatpak ebook-convert command
alias ebook-convert='flatpak run --command=ebook-convert com.calibre_ebook.calibre'
# Libreoffice conversions
alias loffcon='flatpak run org.libreoffice.LibreOffice --convert-to'
alias pdfify='loffcon pdf'

alias nvimup='nvim +PlugInstall +PlugUpdate +PlugUpgrade +CocStart +CocUpdate +qa'
alias nvimclean='nvim +PlugClean'

alias dnfs='dnf search'
# alias weechat-matrix='source $HOME/Downloads/gitclone/weechat-matrix/venv/bin/activate && weechat -r '/script load matrix.py; /matrix connect matrix_org''
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

alias settmp='redshift -O'
alias resettmp='redshift -x'
# fzf, z, etc.
alias z='z -I'

# kitty-specific
alias kicat='kitty +kitten icat'
alias kittyrc='$EDITOR $HOME/.config/kitty/kitty_master.conf'

if command -v roflcat > /dev/null; then
	alias lolcat='roflcat -t'
fi

# zsh-specific
if [ -n "$ZSH_VERSION" ]; then
	alias -g isotime='$(date -Iseconds)'
	alias -g nnote='$(date +%Y-%m-%d_%H-%M-%S_%s).md'
	alias -g detch='&>/dev/null 2>/dev/null & disown'
	alias -g pagit='| $PAGER'
	alias -g w3m-htm='| w3m -T text/html'
	if command -v lolcat > /dev/null; then
		alias -g rofl='| lolcat'
	fi
fi
