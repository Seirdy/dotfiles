#!/usr/bin/env dash
# Update small programs that are compiled with a C compiler

gohome() {
	cd "$HOME/Downloads/gitclone" || return 1
}

mkdir -p "$HOME/Downloads/gitclone" || exit 1

prepare() {
	gohome
	if [ ! -d "./$1" ]; then
		git clone "$2"
	fi
	cd "$1" || return 1
	git pull
	git submodule update --init --recursive --remote
}

export PREFIX="$HOME/.local"
export BINPREFIX="$HOME/.local/bin"
export PREFIX="$HOME/.local"
export MANPREFIX="$HOME/.local/man"
export DATAPREFIX="$HOME/.local/share"
export CONFIGPREFIX="$HOME/.config"

# imv
prepare imv https://github.com/eXeC64/imv && make install

# conmon
prepare conmon https://github.com/containers/conmon && make podman

prepare cmatrix https://github.com/abishekvashok/cmatrix \
	&& mkdir -p build \
	&& cd build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX="$PREFIX" -DCMAKE_BUILD_TYPE=Release
