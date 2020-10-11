#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=/home/rkumar/startup.sh
# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_vars.sh
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

# lua
ghq_get_cd 'https://github.com/lua/lua.git' \
	&& make CFLAGS="$CFLAGS -DLUA_USE_LINUX" \
	&& strip lua \
	&& install -m 0755 lua "$BINPREFIX" \
	&& install -m 0644 lua.h luaconf.h lualib.h lauxlib.h "$INCLUDEPREFIX" \
	&& install -m 0644 liblua.a "$LIBPREFIX"
# wob
ghq_get_cd 'https://github.com/francma/wob.git' \
	&& meson build-release --buildtype release --prefix "$PREFIX" \
	&& ninja -C build-release \
	&& ninja -C build-release install

# file(1)
ghq_get_cd https://github.com/file/file.git && simple_autotools

# chafa
ghq_get_cd https://github.com/hpjansson/chafa.git \
	&& ./autogen.sh && configure_install

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

# lrzip
ghq_get_cd 'https://github.com/ckolivas/lrzip.git' && CFLAGS="$CFLAGS -fomit-frame-pointer" CXXFLAGS="$CXXFLAGS -fomit-frame-pointer" simple_autotools --enable-asm

# atool
ghq_get_cd https://repo.or.cz/atool.git && simple_autotools

# premake; build-time dependency of otfcc
ghq_get_cd https://github.com/premake/premake-core.git \
	&& make -f Bootstrap.mak linux \
	&& install -m 0755 bin/release/premake5 "$BINPREFIX"

# otfcc
ghq_get_cd https://github.com/caryll/otfcc.git \
	&& premake5 gmake \
	&& cd build/gmake \
	&& make config=release_x64 \
	&& install -m 0755 "$GHQ_ROOT/github.com/caryll/otfcc/bin/release-x64"/otfcc* "$BINPREFIX"

# cflags for building some libs
cflags_old="$CFLAGS"
export CFLAGS="-fPIC $CFLAGS_LTO" LDFLAGS="-fPIC $CFLAGS_LTO" CPPFLAGS="-fPIC $CFLAGS_LTO" CXXFLAGS="-fPIC $CFLAGS_LTO" 
# aom reference impl.
ghq_get_cd https://aomedia.googlesource.com/aom.git \
	&& fancy_cmake -DCONFIG_HIGHBITDEPTH=1 -DENABLE_TESTS=0
ghq_get_cd 'https://code.videolan.org/videolan/libplacebo.git' && simple_meson -Dvulkan=enabled -Dshaderc=enabled
ghq_get_cd https://code.videolan.org/videolan/dav1d.git && simple_meson -Denable_asm=true -Denable_avx512=true -Denable_tests=false --default-library=static

export CFLAGS="$cflags_old" LDFLAGS="$cflags_old" CPPFLAGS="$cflags_old" CXXFLAGS="$cflags_old" 

# avif encoding and decoding (converting to png)
ghq get -u https://github.com/link-u/cavif.git && ghq get -u https://github.com/link-u/davif.git
# prepare cavif deps that don't get cloned
[ -d "$GHQ_ROOT/github.com/link-u/cavif/external/Little-CMS" ] \
	|| git clone --recurse-submodules --recursive \
		git@github.com:mm2/Little-CMS.git \
		"$GHQ_ROOT/github.com/link-u/cavif/external/Little-CMS"
[ -d "$GHQ_ROOT/github.com/link-u/davif/external/Little-CMS" ] \
	|| {
		mkdir -p "$GHQ_ROOT/github.com/link-u/davif/external/" \
			&& cp -r "$GHQ_ROOT/github.com/link-u/cavif/external/Little-CMS" "$GHQ_ROOT/github.com/link-u/davif/external/Little-CMS"
	}
cd "$GHQ_ROOT/github.com/link-u/davif" && fancy_cmake
cd "$GHQ_ROOT/github.com/link-u/cavif" && fancy_cmake

# waifu2x-ncnn-vulkan
ghq_get_cd https://github.com/nihui/waifu2x-ncnn-vulkan.git \
	&& mkdir -p build && cd build \
	&& cmake ../src -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$CMAKE_INSTALL_PREFIX" -DCMAKE_INSTALL_MANDIR="$CMAKE_INSTALL_MANDIR" \
	&& cmake --build . --target install \
	&& install -m 0755 ./waifu2x-ncnn-vulkan "$BINPREFIX"

# mpv, with ffmpeg/libass statically linked
# shellcheck disable=SC2169
ghq_get_cd https://github.com/mpv-player/mpv-build.git \
	&& /bin/printf '--arch=x86_64\n--enable-version3\n--enable-bzlib\n--disable-crystalhd\n--enable-fontconfig\n--enable-frei0r\n--enable-gcrypt\n--enable-gnutls\n--enable-ladspa\n--enable-libaom\n--enable-libdav1d\n--enable-libass\n--disable-libcdio\n--enable-libdrm\n--enable-libjack\n--enable-libfreetype\n--enable-libfribidi\n--enable-libgsm\n--enable-libmp3lame\n--enable-nvenc\n--enable-openal\n--enable-opencl\n--enable-opengl\n--enable-libopenjpeg\n--enable-libopus\n--enable-libpulse\n--enable-librsvg\n--enable-libsoxr\n--enable-libspeex\n--enable-libssh\n--enable-libtheora\n--enable-libvorbis\n--enable-libv4l2\n--enable-libvidstab\n--enable-libvmaf\n--enable-libvpx\n--enable-libwebp\n--enable-libx264\n--enable-libx265\n--enable-libxvid\n--enable-libzimg\n--enable-libzvbi\n--enable-avfilter\n--enable-avresample\n--enable-postproc\n--enable-pthreads\n--enable-gpl\n--disable-debug\n--enable-libmfx\n--enable-runtime-cpudetect' >ffmpeg_options \
	&& /bin/printf "--prefix=$PREFIX\n--datarootdir=$CONFIGPREFIX\n--mandir=$MANPREFIX\n--confdir=$CONFIGPREFIX\n--lua=luajit\n--disable-android\n--disable-audiounit\n--disable-caca\n--disable-cdda\n--disable-cocoa\n--disable-coreaudio\n--disable-cuda-hwaccel\n--disable-cuda-interop\n--disable-d3d-hwaccel\n--disable-d3d11\n--disable-d3d9-hwaccel\n--disable-debug-build\n--disable-direct3d\n--disable-dvdnav\n--disable-egl-android\n--disable-egl-angle\n--disable-egl-angle-lib\n--disable-egl-angle-win32\n--disable-egl-x11\n--disable-gl-cocoa\n--disable-gl-dxinterop\n--disable-gl-dxinterop-d3d9\n--disable-gl-win32\n--disable-gl-x11\n--disable-ios-gl\n--disable-libbluray\n--disable-macos-10-11-features\n--disable-macos-10-12-2-features\n--disable-macos-10-14-features\n--disable-macos-cocoa-cb\n--disable-macos-media-player\n--disable-macos-touchbar\n--disable-rpi\n--disable-rpi-mmal\n--disable-sdl2\n--disable-swift\n--disable-tvos\n--disable-vaapi-x-egl\n--disable-vaapi-x11\n--disable-vdpau\n--disable-videotoolbox-gl\n--disable-wasapi\n--disable-win32-internal-pthreads\n--disable-x11\n--disable-xv\n--enable-gl-wayland\n--enable-libarchive\n--enable-libmpv-shared\n--enable-vaapi-wayland\n--enable-wayland\n--enable-wayland-protocols\n--enable-wayland-scanner\n--enable-shaderc\n--enable-vulkan" >mpv_options \
	&& dash ./use-ffmpeg-release && dash ./use-mpv-master && dash ./use-libass-master \
	&& dash ./update && dash ./clean \
	&& dash ./scripts/libass-config && dash ./scripts/libass-build \
	&& dash ./scripts/ffmpeg-config && dash ./scripts/ffmpeg-build \
	&& export CFLAGS="$CFLAGS_LTO" \
		LDFLAGS="$CFLAGS_LTO" \
		CXXFLAGS="$CFLAGS_LTO" \
		CPPFLAGS="$CFLAGS_LTO"

# i tried a bunch of things, but liblua.a causes problems with programs that expect luajit or lua 5.{1,2}
# so do this horrible hack instead: move liblua.a somewhere else, build those programs, and move it back.
if [ -f "$LIBPREFIX/liblua.a" ]; then
	luastatic="$LIBPREFIX/liblua.a"
	mv "$luastatic" "${luastatic}_foo"
fi

cd "$GHQ_ROOT/github.com/mpv-player/mpv-build" \
	&& dash ./scripts/mpv-config && dash ./scripts/mpv-build && dash ./install

[ -n "$luastatic" ] && mv "${luastatic}_foo" "$luastatic"

# mpc, CLI mpd client
ghq_get_cd 'https://github.com/MusicPlayerDaemon/mpc.git' \
	&& simple_meson -Diconv=enabled

# minetest
ghq_get_cd 'https://github.com/minetest/minetest.git' \
	&& git -C games/minetest_game pull \
	&& fancy_cmake \
		-DENABLE_LEVELDB=ON \
		-DENABLE_SPATIAL=ON \
		-DENABLE_REDIS=ON \
		-DENABLE_POSTGRESQL=ON \
		-DENABLE_LUAJIT=ON \
		-DOPENGL_GL_PREFERENCE=GLVND \
		-DBUILD_CLIENT=TRUE -DBUILD_SERVER=TRUE

# nim
ghq get -u https://github.com/nim-lang/Nim.git \
	&& cd "$GHQ_ROOT/github.com/nim-lang/Nim" \
	&& dash ./build_all.sh \
	&& cp build/* "$NIMBLE_DIR/bin"

ghq_get_cd 'https://github.com/martanne/abduco.git' && CC='musl-gcc -static' CFLAGS="$CFLAGS -static" configure_install

# czmod, used by z.lua for a speedup
ghq_get_cd 'https://github.com/skywind3000/czmod.git' && ./build.sh

# wf-recorder: wlroots screen recording
ghq_get_cd 'https://github.com/ammen99/wf-recorder.git' && simple_meson -Dopencl=enabled

# scdoc
ghq_get_cd https://git.sr.ht/~sircmpwn/scdoc && sed -E 's/ ?-Werror//g' Makefile >Makefile.noerr && make -f Makefile.noerr && make install

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

# speedtest cli
ghq_get_cd https://github.com/taganaka/SpeedTest.git && fancy_cmake

# atool
ghq_get_cd https://repo.or.cz/atool.git && simple_autotools

# cmatrix
ghq_get_cd https://github.com/abishekvashok/cmatrix.git \
	&& fancy_cmake

# cxxmatrix: much more advanced than cmatrix
# uses hankaku kana characters + different sahdes + different scenes.
ghq_get_cd https://github.com/akinomyoga/cxxmatrix && make_install

# bcal
ghq_get_cd https://github.com/jarun/bcal.git && make_install

# nnn
ghq_get_cd https://github.com/jarun/nnn.git && make -O_ICONS=1 -O_PCRE=1 strip && make install

ghq_get_cd https://github.com/openSUSE/catatonit.git && simple_autotools

# kitty
ghq_get_cd https://github.com/kovidgoyal/kitty.git \
	&& python3 ./setup.py linux-package --update-check-interval=0 --prefix="$PREFIX"

# dash shell, static binary
ghq_get_cd https://git.kernel.org/pub/scm/utils/dash/dash.git \
	&& env NOCONFIGURE=1 ./autogen.sh \
	&& CC='musl-gcc -static' CFLAGS="$CFLAGS -static" LDFLAGS="$LDFLAGS -static" configure_install

# cava - I only use it with MPD FIFO, no need for ALSA/Pulse
ghq_get_cd https://github.com/karlstav/cava.git \
	&& ./autogen.sh \
	&& FONT_DIR="$DATAPREFIX/fonts" CC='musl-gcc' configure_install \
		--disable-input-alsa \
		--disable-input-pulse \
		--disable-input-portaudio \
		--disable-input-sndio

# radeontop if a Radeon GPU is detected
needs_radeontop() {
	lspci -mm \
		| awk -F '\"|\" \"|\\(' \
			'/"Display|"3D|"VGA/ {a[$0] = $1 " " $3 " " $4}
			END {for(i in a) {if(!seen[a[i]]++) print a[i]}}' \
		| grep -i radeon >/dev/null
}

needs_radeontop \
	&& ghq_get_cd https://github.com/clbr/radeontop.git \
	&& make amdgpu=1 xcb=1 nls=0 install

# cli-visualizer
ghq_get_cd https://github.com/dpayne/cli-visualizer.git \
	&& CFLAGS="$CFLAGS_SIMPLE" \
		CPPFLAGS="$CFLAGS_SIMPLE" \
		LDFLAGS="$CFLAGS_SIMPLE" \
		CXXFLAGS="$CFLAGS_SIMPLE" \
		fancy_cmake
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

# another important tool
ghq_get_cd https://github.com/jaseg/lolcat && DESTDIR=$PREFIX/bin make_install

# ncmpcpp, with only the features i use
ghq_get_cd https://github.com/arybczak/ncmpcpp.git \
	&& ./autogen.sh \
	&& configure_install --disable-static --with-taglib --with-gnu-ld

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
