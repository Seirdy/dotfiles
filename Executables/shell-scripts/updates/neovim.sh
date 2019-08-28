#!/usr/bin/env dash

cd "$HOME/Downloads/gitclone" || exit 1
if [ -d neovim ]; then
	cd neovim
	git pull
else
	git clone https://github.com/neovim/neovim
	cd neovim
fi

export PREFIX="$HOME/.local"
export BINPREFIX="$HOME/.local/bin"
export DATAPREFIX="$HOME/.local/share"
export MANPREFIX="$HOME/.local/man"
export CONFIGPREFIX="$HOME/.config"
export CMAKE_INSTALL_PREFIX="$PREFIX"
export CMAKE_INSTALL_MANDIR="$MANPREFIX"

make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX -DCMAKE_INSTALL_MANDIR=$CMAKE_INSTALL_MANDIR"
make install
