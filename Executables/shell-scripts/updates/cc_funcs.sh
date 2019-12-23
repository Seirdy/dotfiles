#!/bin/sh

export PREFIX="$HOME/.local"
export BINPREFIX="$PREFIX/bin"
export MANPREFIX="$PREFIX/man"
export DATAPREFIX="$PREFIX/share"
export CONFIGPREFIX="$HOME/.config"
export CONFIGPREFIX="$HOME/.config"
export CMAKE_INSTALL_PREFIX="$PREFIX"
export CMAKE_INSTALL_MANDIR="$MANPREFIX"

export LIBLDFLAGS='-z lazy'
export CFLAGS='-O3 -mtune=native -march=native -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection'
export CXXFLAGS='-O3 -mtune=native -march=native -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection'
export FFLAGS='-O3 -mtune=native -march=native -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -I/usr/lib64/gfortran/modules'
export FCFLAGS='-O3 -mtune=native -march=native -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -I/usr/lib64/gfortran/modules'

threads=$(getconf _NPROCESSORS_ONLN)

fancy_cmake() {
	mkdir -p build && cd build \
		&& cmake .. \
			-DCMAKE_BUILD_TYPE=Release \
			-DCMAKE_INSTALL_PREFIX="$CMAKE_INSTALL_PREFIX" \
			-DCMAKE_INSTALL_MANDIR="$CMAKE_INSTALL_MANDIR" \
			"$@"
}

make_install() {
	make -j "$threads" \
		&& make install
}

fancy_configure() {
	./configure \
		--program-prefix= \
		--prefix="$PREFIX" \
		--exec-prefix="$PREFIX" \
		--bindir="$BINPREFIX" \
		--datadir="$XDG_DATA_HOME" \
		--includedir="$HOME/.local/include" \
		--libdir="$HOME/.local/lib64" \
		--libexecdir="$HOME/.local/libexec" \
		--mandir="$MANPREFIX" \
		--infodir="$HOME/.local/share/info" \
		"$@"
}

configure_install() {
	fancy_configure "$@" && make_install
}

simple_autotools() {
	autoreconf -fi && configure_install "$@"
}

simple_meson() {
	meson build --prefix "$PREFIX" --libdir="$PREFIX/lib" \
		&& ninja -C build \
		&& ninja -C build install
}
