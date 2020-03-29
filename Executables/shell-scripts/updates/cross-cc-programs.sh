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

# mpv, with ffmpeg/libass statically linked
# shellcheck disable=SC2169
ghq_get_cd https://github.com/mpv-player/mpv-build.git \
	&& /bin/printf '--arch=x86_64\n--enable-version3\n--enable-bzlib\n--disable-crystalhd\n--enable-fontconfig\n--enable-frei0r\n--enable-gcrypt\n--enable-gnutls\n--enable-ladspa\n--enable-libaom\n--enable-libdav1d\n--enable-libass\n--enable-libcdio\n--enable-libdrm\n--enable-libjack\n--enable-libfreetype\n--enable-libfribidi\n--enable-libgsm\n--enable-libmp3lame\n--enable-nvenc\n--enable-openal\n--enable-opencl\n--enable-opengl\n--enable-libopenjpeg\n--enable-libopus\n--enable-libpulse\n--enable-librsvg\n--enable-libsoxr\n--enable-libspeex\n--enable-libssh\n--enable-libtheora\n--enable-libvorbis\n--enable-libv4l2\n--enable-libvidstab\n--enable-libvmaf\n--enable-libvpx\n--enable-libwebp\n--enable-libx264\n--enable-libx265\n--enable-libxvid\n--enable-libzimg\n--enable-libzvbi\n--enable-avfilter\n--enable-avresample\n--enable-postproc\n--enable-pthreads\n--enable-gpl\n--disable-debug\n--enable-libmfx\n--enable-runtime-cpudetect' >ffmpeg_options \
	&& /bin/printf "--prefix=$PREFIX\n--datarootdir=$CONFIGPREFIX\n--mandir=$MANPREFIX\n--confdir=$CONFIGPREFIX\n--lua=luajit\n--disable-android\n--disable-audiounit\n--disable-caca\n--disable-cdda\n--disable-cocoa\n--disable-coreaudio\n--disable-cuda-hwaccel\n--disable-cuda-interop\n--disable-d3d-hwaccel\n--disable-d3d11\n--disable-d3d9-hwaccel\n--disable-debug-build\n--disable-direct3d\n--disable-dvdnav\n--disable-egl-android\n--disable-egl-angle\n--disable-egl-angle-lib\n--disable-egl-angle-win32\n--disable-egl-x11\n--disable-gl-cocoa\n--disable-gl-dxinterop\n--disable-gl-dxinterop-d3d9\n--disable-gl-win32\n--disable-gl-x11\n--disable-ios-gl\n--disable-libbluray\n--disable-macos-10-11-features\n--disable-macos-10-12-2-features\n--disable-macos-10-14-features\n--disable-macos-cocoa-cb\n--disable-macos-media-player\n--disable-macos-touchbar\n--disable-rpi\n--disable-rpi-mmal\n--disable-sdl2\n--disable-swift\n--disable-tvos\n--disable-vaapi-x-egl\n--disable-vaapi-x11\n--disable-vdpau-gl-x11\n--disable-videotoolbox-gl\n--disable-wasapi\n--disable-win32-internal-pthreads\n--disable-x11\n--disable-xv\n--enable-gl-wayland\n--enable-libarchive\n--enable-libmpv-shared\n--enable-vaapi-wayland\n--enable-wayland\n--enable-wayland-protocols\n--enable-wayland-scanner" >mpv_options \
	&& dash ./use-ffmpeg-master && dash ./use-mpv-master && dash ./use-libass-master \
	&& dash ./update && dash ./clean \
	&& dash ./scripts/libass-config && dash ./scripts/libass-build \
	&& dash ./scripts/ffmpeg-config && dash ./scripts/ffmpeg-build

export CFLAGS="$CFLAGS_LTO" \
	LDFLAGS="$CFLAGS_LTO" \
	CXXFLAGS="$CFLAGS_LTO" \
	CPPFLAGS="$CFLAGS_LTO"

cd "$GHQ_ROOT/github.com/mpv-player/mpv-build" \
	&& dash ./scripts/mpv-config && dash ./scripts/mpv-build && dash ./install
# wob
ghq_get_cd 'https://github.com/francma/wob.git' \
	&& meson build-release --buildtype release --prefix "$PREFIX" \
	&& ninja -C build-release \
	&& ninja -C build-release install

# zstd
ghq_get_cd https://github.com/facebook/zstd.git \
	&& cd build/meson \
	&& meson setup \
		--prefix "$PREFIX" \
		--libdir "$PREFIX/lib" \
		--buildtype release \
		--optimization 3 \
		-Dbin_programs=true \
		-Dbin_contrib=true \
		--wipe \
		builddir \
	&& ninja -C builddir && ninja -C builddir install

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

# static, portable zsh
ghq_get_cd git@git.sr.ht:~seirdy/zsh-bin \
	&& {
		oldfile="$(echo ./zsh-*-linux-x86_64.tar.gz)" \
			&& [ -e "$oldfile" ] && mv "$oldfile" "${oldfile%.*.*}.old.tar.gz"
	} || echo 'no previous builds' \
	&& dash ./build -d podman -g latest || echo 'done'
tar -xzf ./zsh-*-linux-x86_64.tar.gz \
	&& outdir="$(echo zsh-*-linux-x86_64)" \
	&& install -m 0755 "$outdir/bin/zsh" "$EXECUTABLES/zsh-bin/bin/zsh" \
	&& cp -r "$outdir/share" "$EXECUTABLES/zsh-bin/" \
	&& version="${outdir#*-}" && version="${version%-l*}" \
	&& dash "$EXECUTABLES/zsh-bin/share/zsh/$version/scripts/relocate" \
	&& rm -rf "$outdir"
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
