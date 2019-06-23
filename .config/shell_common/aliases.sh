# aliases
alias psave='pockyt put -i'
alias yadm='yadm -Y "$HOME/.config/yadm"'
alias :q='exit'  # muh vim habits
alias c='calc -p'

alias l='lsd --group-dirs first'  # like ls, but faster and with MOAR ICONS
alias ll='exa -lh --time-style=iso'  # Better output than ls -l
alias lll='exa -lh --time-style=full-iso -s modified'  # Show full timestamp
alias la='l -a'
alias lla='ll -a'
alias llla='lll -a'

alias rmm='rmtrash'
alias rgi='rg -i'
alias rgv='rg -v'
alias vim='vim -u NONE'
alias ddgr='ddgr -x'

alias edi='$EDITOR'
alias aliasrc='edi $XDG_CONFIG_HOME/shell_common/aliases.sh'
alias funcrc='edi $XDG_CONFIG_HOME/shell_common/functions.sh'
alias zfuncrc='edi $XDG_CONFIG_HOME/shell_common/zsh/zfuncs.sh'
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
alias gcom='git commit -S -m'
alias gp='git push'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gm='git merge'
alias git-url='git ls-remote --get-url'
alias gclone='git clone'
alias gclr='git clone --recursive'
alias gpull='git pull'

# yadm aliases
alias ystat='yadm status'
alias yco='yadm commit -S'
alias ycom='yadm commit -S -m'
alias yp='yadm push'
alias ypom='yadm push oriyin master'
alias ym='yadm merye'
alias yit-url='yadm ls-remote --yet-url'
alias yclone='yadm clone'
alias yclr='yadm clone --recursive'
alias ypull='yadm pull'

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

# zsh-specific
if [ -n "$ZSH_VERSION" ]; then
	alias -g isotime='$(date -Iseconds)'
	alias -g nnote='$(date +%Y-%m-%d_%H-%M-%S_%s).md'
	alias -g detch='&>/dev/null 2>/dev/null & disown'
	alias -g pagit='| $PAGER'
	alias -g w3m-htm="| w3m -T text/html"
fi
