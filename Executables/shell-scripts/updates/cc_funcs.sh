#!/bin/sh

# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_vars.sh
. "$HOME/Executables/shell-scripts/updates/cc_vars.sh"

fancy_cmake() {
	mkdir -p build && cd build \
		&& cmake .. \
			-DCMAKE_BUILD_TYPE=Release \
			-DCMAKE_INSTALL_PREFIX="$CMAKE_INSTALL_PREFIX" \
			-DCMAKE_INSTALL_MANDIR="$CMAKE_INSTALL_MANDIR" \
			"$@" \
		&& cmake --build . --target install/strip
}

make_install() {
	make && make install
}

fancy_configure() {
	# shellcheck disable=SC2154
	./configure \
		--program-prefix= \
		--prefix="$PREFIX" \
		--exec-prefix="$PREFIX" \
		--bindir="$BINPREFIX" \
		--datadir="$XDG_DATA_HOME" \
		--includedir="$PREFIX/include" \
		--libdir="$PREFIX/lib64" \
		--libexecdir="$PREFIX/libexec" \
		--mandir="$MANPREFIX" \
		--infodir="$PREFIX/share/info" \
		"$@"
}

configure_install() {
	fancy_configure "$@" && make && make install-strip
}

simple_autotools() {
	autoreconf -fi && configure_install "$@"
}

_simple_meson_no_reconfigure() {
	meson build --prefix "$PREFIX" --libdir "$PREFIX/lib" --buildtype release --optimization 3 "$@" \
		&& ninja -C build \
		&& ninja -C build install
}
# try reconfiguring. if it hasn't been configured yet, then don't reconfigure.
simple_meson() {
	_simple_meson_no_reconfigure --reconfigure "$@" || _simple_meson_no_reconfigure "$@"
}
