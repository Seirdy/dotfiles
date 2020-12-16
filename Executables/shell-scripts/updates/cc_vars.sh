#!/bin/sh

# shellcheck source=/home/rkumar/startup.sh
[ -z "$PROFILE_SET" ] && . "$HOME/startup.sh"
[ -z "$PREFIX" ] && export PREFIX="$HOME/.local"
export BINPREFIX="$PREFIX/bin"
export INCLUDEPREFIX="$PREFIX/include"
export LIBPREFIX="$PREFIX/lib"
export DATAPREFIX="$PREFIX/share"
export MANPREFIX="$DATAPREFIX/man"
# shellcheck disable=SC2154
[ -z "$CONFIGPREFIX" ] && export CONFIGPREFIX="$XDG_CONFIG_HOME"
export CMAKE_INSTALL_PREFIX="$PREFIX"
export CMAKE_INSTALL_MANDIR="$MANPREFIX"
export SYSTEMD_UNIT_PATH="$CONFIGPREFIX/systemd/user"
PKG_CONFIG_PATH="$DATAPREFIX/pkgconfig:$LIBPREFIX/pkgconfig:$PREFIX/lib64/pkgconfig:$(pkg-config --variable pc_path pkg-config)"
export PKG_COFNIG_PATH

mkdir -p "$PREFIX" "$BINPREFIX" "$MANPREFIX" "$DATAPREFIX" "$SYSTEMD_UNIT_PATH"

export LIBLDFLAGS='-z lazy'
[ -z "$ARCH" ] && ARCH='native'

# shellcheck disable=SC2154
if [ "$CROSS_COMPILING" = 1 ]; then
	export EXECUTABLES="$HOME/Executables/lappie/Executables"
else
	export EXECUTABLES="$HOME/Executables"
fi
CFLAGS="-O3 -DNDEBUG -mcpu=$ARCH -mtune=$ARCH -march=$ARCH -g -pipe -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -s -Wno-error=unused-parameter -Wno-error=unused-variable"
export CLANGFLAGS="$CXXFLAGS -fuse-ld=lld -L. -Wno-error=unused-command-line-argument -Wno-error=unused-parameter -Wno-error=unused-variable -Wno-error=unused-private-field"
export CFLAGS="$CFLAGS -Wno-error=unused-but-set-variable -fstack-clash-protection"
export LDFLAGS="$CFLAGS" # strip binaries
export CXXFLAGS="$CFLAGS"
export CPPFLAGS="$CFLAGS"
export FFLAGS="$CFLAGS -I/usr/lib64/gfortran/modules"
export FCFLAGS="$FFLAGS"
export RUSTFLAGS="-C opt-level=3 -C target-cpu=$ARCH -C link-arg=-s"
export CFLAGS_LTO="$CFLAGS -flto"
export CFLAGS_SIMPLE='-O3 -march=native -g -pipe -s -flto -m64'
[ -z "$CARGO_INSTALL_OPTS" ] && export CARGO_INSTALL_OPTS='--all-features -Z unstable-options'

# For builds using Clang instead of GCC, I replace C(XX)FLAGS with CLANGFLAGS
export CLANGFLAGS_LTO="$CLANGFLAGS -flto"
export CLANGFLAGS_UNUSED_STUFF="$CLANGFLAGS_LTO"

export GOOS=linux GOARCH=amd64
export GOFLAGS='-ldflags=-s -ldflags=-w'

THREADS="$(getconf _NPROCESSORS_ONLN)"
# if we're not in litemode, then lots of tasks will be running in parallel; some will
# parallelize across $THREADS threads. Reduce $THREADS a bit to account for this.
# shellcheck disable=SC2154
[ "$LITEMODE" = 1 ] || THREADS="$((THREADS / 2))"
export THREADS
export MAKEFLAGS="-j $THREADS"
export CARGO_BUILD_JOBS="$THREADS"
