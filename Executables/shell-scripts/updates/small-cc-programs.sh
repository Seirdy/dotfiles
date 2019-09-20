#!/usr/bin/env dash
# Update small programs that are compiled with a C compiler

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"

export PREFIX="$HOME/.local"
export BINPREFIX="$HOME/.local/bin"
export PREFIX="$HOME/.local"
export MANPREFIX="$HOME/.local/man"
export DATAPREFIX="$HOME/.local/share"
export CONFIGPREFIX="$HOME/.config"

imv
ghq_get_cd https://github.com/eXeC64/imv.git && make install

# cmatrix
ghq_get_cd https://github.com/abishekvashok/cmatrix.git \
	&& mkdir -p build \
	&& cd build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX="$PREFIX" -DCMAKE_BUILD_TYPE=Release \
	&& cmake --build . --target install

# conmon; necessary for building OCI container stack
ghq_get_cd https://github.com/containers/conmon.git && make podman

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
