#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"
# shellcheck source=./cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

# xdg-dbus-proxy: runtime dep for flatpak programs
ghq_get_cd https://github.com/flatpak/xdg-dbus-proxy.git \
	&& env NOCONFIGURE=1 ./autogen.sh \
	&& configure_install \
		--with-system-bubblewrap \
		--with-system-dbus-proxy \
		--with-priv-mode=none

# bubblewrap: sandbox any command. Dependency of Flatpak
ghq_get_cd https://github.com/containers/bubblewrap.git \
	&& env NOCONFIGURE=1 ./autogen.sh \
	&& fancy_configure \
	&& make \
	&& install -m 0755 ./bwrap "$BINPREFIX/bwrap" \
	&& install -m 0644 bwrap.1 "$MANPREFIX/man1"

# flatpak
ghq_get_cd https://github.com/flatpak/flatpak \
	&& ./autogen.sh \
	&& configure_install --with-system-bubblewrap --with-system-dbus-proxy

ghq_get_cd https://github.com/flatpak/flatpak-builder.git \
	&& ./autogen.sh \
	&& configure_install \
		--enable-docbook-docs \
		--with-dwarf-header=/usr/include/libdwarf

# projectM visualizer
ghq_get_cd https://github.com/projectM-visualizer/projectm.git \
	&& simple_autotools --enable-sdl --enable-threading --enable-pulseaudio

# weechat
ghq_get_cd https://github.com/weechat/weechat.git \
	&& fancy_cmake \
		-DCMAKE_BUILD_TYPE=Release \
		-DENABLE_ENCHANT=ON \
		-DENABLE_PHP=OFF \
		-DENABLE_LUA=ON \
		-DENABLE_TCL=ON \
		-DENABLE_RUBY=ON \
		-DENABLE_GUILE=ON \
		-DENABLE_PYTHON3=ON \
		-DENABLE_DOC=ON \
		-DENABLE_MAN=ON \
		-DENABLE_JAVASCRIPT=OFF \
		-DCA_FILE=/etc/pki/tls/certs/ca-bundle.crt
export CFLAGS="$CFLAGS_LTO"
export CXXFLAGS="$CFLAGS_LTO"
export CPPFLAGS="$CXXFLAGS"

ghq_get_cd https://github.com/mpv-player/mpv.git \
	&& ./bootstrap.py \
	&& ./waf configure \
		--prefix="$PREFIX" \
		--datarootdir="$CONFIGPREFIX" \
		--mandir="$MANPREFIX" \
		--confdir="$CONFIGPREFIX" \
		--enable-libmpv-shared \
		--enable-sdl2 \
		--enable-libarchive \
		--enable-libsmbclient \
		--enable-dvdnav \
		--enable-cdda \
		--enable-html-build \
		--disable-debug-build \
		--disable-android \
		--disable-tvos \
		--disable-egl-android \
		--disable-swift \
		--disable-win32-internal-pthreads \
		--disable-coreaudio \
		--disable-audiounit \
		--disable-cocoa \
		--disable-gl-cocoa \
		--disable-gl-win32 \
		--disable-gl-dxinterop \
		--disable-egl-angle \
		--disable-egl-angle-lib \
		--disable-egl-angle-win32 \
		--disable-direct3d \
		--disable-wasapi \
		--disable-d3d11 \
		--disable-ios-gl \
		--disable-d3d-hwaccel \
		--disable-d3d9-hwaccel \
		--disable-gl-dxinterop-d3d9 \
		--disable-cuda-hwaccel \
		--disable-cuda-interop \
		--enable-dvbin \
		--disable-macos-touchbar \
		--disable-macos-10-11-features \
		--disable-macos-10-12-2-features \
		--disable-macos-10-14-features \
		--disable-macos-media-player \
		--disable-macos-cocoa-cb \
		--disable-rpi-mmal \
		--disable-rpi \
	&& ./waf && ./waf install
# neovim
ghq_get_cd https://github.com/neovim/neovim.git \
	&& luarocks build --local mpack \
	&& luarocks build --local lpeg \
	&& luarocks build --local inspect \
	&& fancy_cmake -DUSE_BUNDLED=OFF -DENABLE_LTO=ON

# ncmpcpp, with only the features i use
ghq_get_cd https://github.com/arybczak/ncmpcpp.git \
	&& ./autogen.sh \
	&& configure_install --disable-static --with-taglib --with-curl

# zsh
# install-strip always fails at the last step, but the important steps succeed
export zsh_cv_sys_nis=no
ghq_get_cd git://git.code.sf.net/p/zsh/code \
	&& autoreconf -fi \
	&& sed -e 's|^\.NOTPARALLEL|#.NOTPARALLEL|' -i 'Config/defs.mk.in' \
	&& ./Util/preconfig \
	&& fancy_configure --with-tcsetpgrp --enable-maildir-support --enable-pcre \
	&& make -C Src headers \
	&& make -C Src -f Makemod zshpaths.h zshxmods.h version.h \
	&& make \
	&& make install-strip

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
