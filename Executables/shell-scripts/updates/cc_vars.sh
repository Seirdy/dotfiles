#!/bin/sh

# shellcheck source=/home/rkumar/startup.sh
[ -z "$PROFILE_SET" ] && . "$HOME/startup.sh"
[ -z "$PREFIX" ] && export PREFIX="$HOME/.local"
export BINPREFIX="$PREFIX/bin"
export MANPREFIX="$PREFIX/man"
export DATAPREFIX="$PREFIX/share"
# shellcheck disable=SC2154
[ -z "$CONFIGPREFIX" ] && export CONFIGPREFIX="$XDG_CONFIG_HOME"
export CMAKE_INSTALL_PREFIX="$PREFIX"
export CMAKE_INSTALL_MANDIR="$MANPREFIX"
export SYSTEMD_UNIT_PATH="$CONFIGPREFIX/systemd/user"

mkdir -p "$PREFIX" "$BINPREFIX" "$MANPREFIX" "$DATAPREFIX" "$SYSTEMD_UNIT_PATH"

export LIBLDFLAGS='-z lazy'
[ -z "$ARCH" ] && ARCH='native'
export CFLAGS="-O3 -DNDEBUG -mcpu=$ARCH -mtune=$ARCH -march=$ARCH -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -s -Wno-error=unused-command-line-argument -Wno-error=unused-parameter -Wno-error=unused-variable -Wno-error=unused-private-field"
export LDFLAGS="$CFLAGS" # strip binaries
export CXXFLAGS="$CFLAGS"
export CPPFLAGS="$CFLAGS"
export FFLAGS="$CFLAGS -I/usr/lib64/gfortran/modules"
export FCFLAGS="$FFLAGS"
export RUSTFLAGS="-C opt-level=3 -C target-cpu=$ARCH -C link-arg=-s"
export CFLAGS_LTO="$CFLAGS -flto -fuse-linker-plugin"
[ -z "$CARGO_INSTALL_OPTS" ] && export CARGO_INSTALL_OPTS='--all-features -Z unstable-options'

# For builds using Clang instead of GCC, I replace C(XX)FLAGS with CLANGFLAGS
CLANGFLAGS=$(echo "$CXXFLAGS -fuse-ld=lld -L. -Wno-error=unused-command-line-argument -Wno-error=unused-parameter -Wno-error=unused-variable -Wno-error=unused-private-field" | sed 's/ -fstack-clash-protection//g')
export CLANGFLAGS
export CLANGFLAGS_LTO="$CLANGFLAGS -flto"
export CLANGFLAGS_UNUSED_STUFF="$CLANGFLAGS_LTO"

export GOFLAGS='-ldflags=-s -ldflags=-w'

THREADS=$(getconf _NPROCESSORS_ONLN)
export THREADS
export MAKEFLAGS="-j $THREADS"
