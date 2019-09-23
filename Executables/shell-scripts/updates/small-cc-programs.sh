#!/usr/bin/env dash
# Update small programs that are compiled with a C compiler

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"

export PREFIX="$HOME/.local"
export BINPREFIX="$PREFIX/bin"
export MANPREFIX="$PREFIX/man"
export DATAPREFIX="$PREFIX/share"
export CONFIGPREFIX="$HOME/.config"

# imv
ghq_get_cd https://github.com/eXeC64/imv.git && make && make install

# cmatrix
ghq_get_cd https://github.com/abishekvashok/cmatrix.git \
	&& mkdir -p build \
	&& cd build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX="$PREFIX" -DCMAKE_BUILD_TYPE=Release \
	&& cmake --build . --target install

ghq_get_cd https://github.com/jarun/bcal.git && make && make install

# conmon; necessary for building OCI container stack
ghq_get_cd https://github.com/containers/conmon.git && make podman

# bubblewrap: sandbox any command. Dependency of flatpak
ghq_get_cd https://github.com/containers/bubblewrap.git \
	&& env NOCONFIGURE=1 ./autogen.sh \
	&& ./configure --prefix="$PREFIX" --libdir="$PREFIX/lib64" \
	&& make \
	&& install -m 0755 ./bwrap "$BINPREFIX/bwrap" \
	&& install -m 0644 bwrap.1 "$HOME/.local/share/man/man1"

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
