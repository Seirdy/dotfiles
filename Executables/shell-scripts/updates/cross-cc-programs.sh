#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=/home/rkumar/startup.sh
# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_vars.sh
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

# wob
ghq_get_cd 'https://github.com/francma/wob.git' \
	&& meson build-release --buildtype release --prefix "$PREFIX" \
	&& ninja -C build-release \
	&& ninja -C build-release install

# file(1)
ghq_get_cd https://github.com/file/file.git && simple_autotools

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

# weechat
ghq_get_cd https://github.com/weechat/weechat.git \
	&& fancy_cmake \
		-DCMAKE_BUILD_TYPE=Release \
		-DENABLE_ENCHANT=ON \
		-DENABLE_PHP=ON \
		-DENABLE_LUA=ON \
		-DENABLE_TCL=ON \
		-DENABLE_RUBY=ON \
		-DENABLE_GUILE=ON \
		-DENABLE_PYTHON3=ON \
		-DENABLE_DOC=ON \
		-DENABLE_MAN=ON \
		-DENABLE_JAVASCRIPT=OFF \
		-DCA_FILE=/etc/pki/tls/certs/ca-bundle.crt

# atool
ghq_get_cd https://repo.or.cz/atool.git && simple_autotools
export CFLAGS="$CFLAGS_LTO" \
	LDFLAGS="$CFLAGS_LTO" \
	CXXFLAGS="$CFLAGS_LTO" \
	CPPFLAGS="$CFLAGS_LTO"
# wob
ghq_get_cd 'https://github.com/francma/wob.git' \
	&& meson build-release --buildtype release --prefix "$PREFIX" \
	&& ninja -C build-release \
	&& ninja -C build-release install

# file(1)
ghq_get_cd https://github.com/file/file.git && simple_autotools

# atool
ghq_get_cd https://repo.or.cz/atool.git && simple_autotools

# cmatrix
ghq_get_cd https://github.com/abishekvashok/cmatrix.git \
	&& fancy_cmake

# rsync
ghq_get_cd git://git.samba.org/rsync.git \
	&& configure_install --with-included-popt

# bcal
ghq_get_cd https://github.com/jarun/bcal.git && make_install

# nnn
ghq_get_cd https://github.com/jarun/nnn.git && make_install

ghq_get_cd https://github.com/openSUSE/catatonit.git && simple_autotools

# kitty
ghq_get_cd https://github.com/kovidgoyal/kitty.git \
	&& python3 ./setup.py linux-package --update-check-interval=0 --prefix="$PREFIX"

# dash shell
ghq_get_cd https://git.kernel.org/pub/scm/utils/dash/dash.git \
	&& env NOCONFIGURE=1 ./autogen.sh \
	&& configure_install

# cava
ghq_get_cd https://github.com/karlstav/cava.git \
	&& ./autogen.sh \
	&& FONT_DIR="$DATAPREFIX/fonts" configure_install

# cli-visualizer
ghq_get_cd https://github.com/dpayne/cli-visualizer.git \
	&& fancy_cmake
# mpdinfo: display current mpd track
ghq_get_cd https://github.com/jduepmeier/mpdinfo.git && make_install

# very important utility; computer basically useless without
ghq_get_cd https://github.com/mtoyoda/sl.git \
	&& make \
	&& install -m0755 sl "$BINPREFIX" \
	&& install -p -m644 sl.1 "$MANPREFIX/man1"

# tmux
ghq_get_cd https://github.com/tmux/tmux.git \
	&& ./autogen.sh \
	&& configure_install

# redshift for Wayland
ghq_get_cd 'https://github.com/minus7/redshift.git' \
	&& ./bootstrap \
	&& configure_install --with-systemduserunitdir="$CONFIGPREFIX/systemd/user"

# another important tool
ghq_get_cd https://github.com/jaseg/lolcat && DESTDIR=$PREFIX/bin make_install

ghq_get_cd https://github.com/mpv-player/mpv.git \
	&& ./bootstrap.py \
	&& ./waf configure \
		--prefix="$PREFIX" \
		--datarootdir="$CONFIGPREFIX" \
		--mandir="$MANPREFIX" \
		--confdir="$CONFIGPREFIX" \
		--enable-libmpv-shared \
		--enable-sdl2 \
		--enable-wayland \
		--enable-wayland-scanner \
		--enable-wayland-protocols \
		--enable-gl-wayland \
		--enable-vaapi-wayland \
		--enable-libarchive \
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

# ncmpcpp, with only the features i use
ghq_get_cd https://github.com/arybczak/ncmpcpp.git \
	&& ./autogen.sh \
	&& configure_install --disable-static --with-taglib --with-curl

# back to regular flags, no LTO
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"
# stuff that needs LDFLAGS empty
unset LIBLDFLAGS

# aria2: download accelerator
ghq_get_cd 'https://github.com/aria2/aria2.git' \
	&& aclocal \
	&& simple_autotools --with-ca-bundle='/etc/ssl/certs/ca-bundle.crt'

# crun: container runtime. Better than runc.
ghq_get_cd https://github.com/containers/crun.git \
	&& ./autogen.sh \
	&& configure_install

# slirp4netns: required for many rootless container setups and Flatpak
ghq_get_cd https://github.com/rootless-containers/slirp4netns \
	&& ./autogen.sh \
	&& configure_install

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
