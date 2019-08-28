#!/usr/bin/env dash

cd "$HOME/Downloads/gitclone" || exit

if [ -d imv ]; then
	cd imv || exit 1
	git pull
else
	git clone https://github.com/eXeC64/imv
	cd imv
fi

export PREFIX="$HOME/.local"
export BINPREFIX="$HOME/.local/bin"
export PREFIX="$HOME/.local"
export MANPREFIX="$HOME/.local/man"
export DATAPREFIX="$HOME/.local/share"
export CONFIGPREFIX="$HOME/.config"

make install
