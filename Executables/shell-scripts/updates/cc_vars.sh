#!/bin/sh

[ -z "$PREFIX" ] && export PREFIX="$HOME/.local"
export BINPREFIX="$PREFIX/bin"
export MANPREFIX="$PREFIX/man"
export DATAPREFIX="$PREFIX/share"
export CONFIGPREFIX="$HOME/.config"
export CMAKE_INSTALL_PREFIX="$PREFIX"
export CMAKE_INSTALL_MANDIR="$MANPREFIX"

export LIBLDFLAGS='-z lazy'
[ -z "$ARCH" ] && ARCH='native'
export CFLAGS="-O3 -DNDEBUG -mcpu=$ARCH -mtune=$ARCH -march=$ARCH -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -s"
export CXXFLAGS="$CFLAGS"
export CPPFLAGS="$CFLAGS"
export FFLAGS="$CFLAGS -I/usr/lib64/gfortran/modules"
export FCFLAGS="$FFLAGS"
export RUSTFLAGS="-C opt-level=3 -C target-cpu=$ARCH"
export CFLAGS_LTO="$CFLAGS -flto -fuse-linker-plugin -fuse-ld=gold"
[ -z "$CARGO_INSTALL_OPTS" ] && export CARGO_INSTALL_OPTS='--all-features -Z unstable-options'

# For builds using Clang instead of GCC, I replace C(XX)FLAGS with CLANGFLAGS
CLANGFLAGS=$(echo "$CXXFLAGS -Wno-error=unused-command-line-argument -flto -fuse-ld=lld -L." | sed 's/ -fstack-clash-protection//g')
export CLANGFLAGS
export CLANGFLAGS_UNUSED_STUFF="$CLANGFLAGS -Wno-error=unused-parameter -Wno-error=unused-variable -Wno-error=unused-private-field"

THREADS=$(getconf _NPROCESSORS_ONLN)
export THREADS
export MAKEFLAGS="-j $THREADS"

