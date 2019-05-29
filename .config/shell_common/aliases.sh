# aliases
alias psave='pockyt put -i'
alias yadm='yadm -Y "$HOME/.config/yadm"'
alias :q='exit'  # muh vim habits
alias l='lsd --group-dirs first'
alias la='l -a'
alias ll='exa -lh --time-style=iso'  # Better output than ls
alias lla='ll -a'  # Show hidden files
alias lll='exa -lh --time-style=full-iso'  # Show full timestamp
alias rmm='rmtrash'
alias rgi='rg -i'
alias vim='vim -u NONE'
alias ddgr='ddgr -x'

alias edi='$EDITOR'
alias aliasrc='edi $HOME/.config/shell_common/aliases.sh'
alias zshrc='edi $HOME/.zshrc'
alias zpluginrc='edi $HOME/.config/shell_common/zplugin.zsh'
alias nvimrc='edi $HOME/.config/nvim/init.vim'
alias startuprc='edi $HOME/startup.sh'
alias rssrc='edi $HOME/.config/newsboat/urls'

# gcc with all the errors
alias gccv='gcc -pedantic -Wall'
# git aliases
alias gstat='git status'
alias gco='git commit -S'
alias gcom='git commit -S -m'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gm='git merge'
alias git-url='git ls-remote --get-url'
alias gclone='git clone'
alias gclr='git clone --recursive'
alias giop='xdg-open $(git-url)'
alias a2c='aria2c -x 5 -s 5 -k 1M -j 3 -c'  # fast aria2c downloading
# ytdl is an executable in my ~/.local/bin that adds flags to youtube-dl not
# contained in my config file
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
alias pdco='pandoc -o'

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
alias cdlog='cd $HOME/Executables/shell-scripts/updates/all_update/logs/*/.'

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
fi
