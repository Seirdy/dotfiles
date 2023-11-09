#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=/home/rkumar/startup.sh
# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_vars.sh
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

# file(1). Upstream gets updated with new formats more often.
ghq_get_cd https://github.com/file/file.git \
	&& simple_autotools --enable-libseccomp --enable-static

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

export CFLAGS="$CFLAGS_LTO" \
	LDFLAGS="$LDFLAGS_LTO" \
	CXXFLAGS="$CFLAGS_LTO" \
	CPPFLAGS="$CFLAGS_LTO"

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
		-DENABLE_PHP=OFF \
		-DENABLE_LUA=ON \
		-DENABLE_TCL=OFF \
		-DENABLE_RUBY=OFF \
		-DENABLE_GUILE=ON \
		-DENABLE_PYTHON=ON \
		-DENABLE_TRIGGER=ON \
		-DENABLE_TYPING=ON \
		-DENABLE_DOC=ON \
		-DENABLE_NLS=OFF \
		-DENABLE_MAN=ON \
		-DENABLE_RELAY=ON \
		-DENABLE_JAVASCRIPT=OFF \
		-DWEECHAT_HOME="~/.weechat" \
		-DCA_FILE=/etc/pki/tls/certs/ca-bundle.crt

# lrzip
ghq_get_cd 'https://github.com/ckolivas/lrzip.git' && CFLAGS="$CFLAGS -fomit-frame-pointer" CXXFLAGS="$CXXFLAGS -fomit-frame-pointer" simple_autotools --enable-asm

# zopfli + zopflipng
export CFLAGS="$CFLAGS_LTO -fpie -static-pie" && export LDFLAGS="$LLDFLAGS_LTO -static-pie" CXXFLAGS="$CFLAGS" CPPFLAGS="$CFLAGS"
ghq_get_cd 'https://github.com/google/zopfli.git' && fancy_cmake -DBUILD_SHARED_LIBS=OFF
export CFLAGS="$CFLAGS_LTO" && export LDFLAGS="$LDFLAGS_LTO" CXXFLAGS="$CFLAGS" CPPFLAGS="$CFLAGS"

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

ghq_get_cd 'https://github.com/swaywm/wlroots.git' \
	&& simple_meson -Dexamples=false -Dxwayland=enabled -Dlogind-provider=systemd -Dlogind=enabled -Dxcb-errors=disabled -Dxcb-icccm=enabled -Dwerror=false --default-library both
ghq_get_cd https://github.com/harfbuzz/harfbuzz.git \
	&& simple_meson -Dcairo=enabled -Dfontconfig=enabled -Dicu=enabled -Dgraphite=enabled -Dgdi=enabled -Ddirectwrite=disabled -Dcoretext=disabled -Dtests=disabled -Ddocs=disabled --default-library=static
ghq_get_cd https://github.com/netflix/vmaf.git && cd libvmaf \
	&& simple_meson -Denable_asm=true -Denable_avx512=false -Denable_tests=false -Denable_float=true -Dbuilt_in_models=true --default-library=static
# for nginx, jpeg-xl, and a bunch of programs using fontconfig
ghq_get_cd https://github.com/google/brotli.git && fancy_cmake
export CFLAGS="$CLANGFLAGS_LTO" CXXFLAGS="$CLANGFLAGS_LTO" CPPFLAGS="$CLANGFLAGS_LTO" LDFLAGS="$LLDFLAGS_LTO" CC='clang' CXX='clang++'
# for jpeg-xl and libaom
ghq_get_cd https://github.com/google/highway.git && fancy_cmake -DBUILD_TESTS=off
addflags="$(pkg-config --libs --cflags --static libbrotlicommon libbrotlienc libbrotlidec)"
export CFLAGS="$CFLAGS $addflags" LDFLAGS="$CFLAGS" CXXFLAGS="$CFLAGS" CPPFLAGS="$CFLAGS"
ghq_get_cd https://gitlab.com/wg1/jpeg-xl.git && fancy_cmake -DJPEGXL_ENABLE_BENCHMARK=false -DJPEGXL_ENABLE_FUZZERS=false -DJPEGXL_FORCE_SYSTEM_HWY=true -DJPEGXL_FORCE_SYSTEM_BROTLI=ON -DBUILD_TESTING=OFF -DJPEGXL_WARNINGS_AS_ERRORS=OFF -DJPEGXL_FORCE_SYSTEM_GTEST=ON

export CFLAGS="$CFLAGS_LTO" LDFLAGS="$LDLAGS_LTO" CXXFLAGS="$CFLAGS_LTO" CPPFLAGS="$CFLAGS_LTO"
unset CC CXX

# aom reference impl.
ghq_get_cd https://aomedia.googlesource.com/aom.git \
	&& fancy_cmake -DCONFIG_HIGHBITDEPTH=1 -DENABLE_TESTS=0 -DBUILD_SHARED_LIBS=0 -DCONFIG_WEBM_IO=1 -DCONFIG_TUNE_VMAF=1 -DCONFIG_TUNE_BUTTERAUGLI=1 -DENABLE_EXAMPLES=1 -DENABLE_CCACHE=1
ghq_get_cd https://gitlab.com/AOMediaCodec/SVT-AV1.git && {
	ln -s Build build || echo 'build directory already created'
} && fancy_cmake -DBUILD_SHARED_LIBS=OFF
ghq_get_cd https://code.videolan.org/videolan/dav1d.git && mkcd build && meson .. -Denable_asm=true -Denable_avx512=false -Denable_tests=false -Denable_tools=true -Denable_examples=false --default-library=static -Db_pgo=generate --prefix="$PREFIX" --libdir="$PREFIX/lib" --buildtype=release && ninja && ./tools/dav1d -i "$HOME/Videos/bench/sol_levante/sol_levante_volcano_libaom.ivf" --framethreads=4 --tilethreads=2 --muxer null -o outfile && meson configure -Db_pgo=use && ninja && ninja install
ghq_get_cd 'https://bitbucket.org/multicoreware/x265_git.git' \
	&& cmake -S source -B build-12 -G Ninja -DCMAKE_INSTALL_PREFIX="$PREFIX" -DHIGH_BIT_DEPTH=TRUE -DMAIN12=TRUE -DEXPORT_C_API=FALSE -DENABLE_CLI=FALSE -DENABLE_SHARED=FALSE -DENABLE_PIC=TRUE -DENABLE_TESTS=FALSE -DENABLE_SHARED=FALSE -DENABLE_LIBNUMA=TRUE -Wno-dev && ninja -C build-12 \
	&& cmake -S source -B build-10 -G Ninja -DCMAKE_INSTALL_PREFIX="$PREFIX" -DHIGH_BIT_DEPTH=TRUE -DEXPORT_C_API=FALSE -DENABLE_CLI=FALSE -DENABLE_SHARED=FALSE -DENABLE_PIC=TRUE -DENABLE_TESTS=FALSE -DENABLE_SHARED=FALSE -DENABLE_LIBNUMA=TRUE -Wno-dev && ninja -C build-10 \
	&& cmake -S source -B build -G Ninja -DCMAKE_INSTALL_PREFIX="$PREFIX" -DENABLE_HDR10_PLUS=TRUE -DEXTRA_LIB='x265_main10.a;x265_main12.a' -DEXTRA_LINK_FLAGS='-L .' -DLINKED_10BIT=TRUE -DLINKED_12BIT=TRUE -DENABLE_CLI=TRUE -DENABLE_PIC=TRUE -DENABLE_TESTS=FALSE -DENABLE_SHARED=FALSE -DENABLE_LIBNUMA=TRUE -Wno-dev \
	&& {
		ln -s ../build-10/libx265.a build/libx265_main10.a && ln -s ../build-12/libx265.a build/libx265_main12.a || echo 'symlinks already exist'
	} \
	&& ninja -C build && ninja -C build install
ghq_get_cd https://github.com/strukturag/libde265.git && simple_autotools --enable-static --disable-shared --disable-arm --with-pic && rm "$PREFIX/bin/test"
ghq_get_cd https://github.com/strukturag/libheif.git && simple_autotools --enable-static --disable-shared --disable-go --disable-examples --enable-local-rav1e --enable-rav1e
ghq_get_cd 'https://chromium.googlesource.com/webm/libvpx.git' \
	&& ./configure \
		--enable-vp8 \
		--enable-vp9 \
		--enable-vp9-highbitdepth \
		--enable-vp9-postproc \
		--enable-pic \
		--enable-temporal-denoising \
		--enable-vp9-decoder \
		--enable-vp9-encoder \
		--enable-experimental \
		--disable-examples \
		--disable-unit-tests \
		--disable-shared \
		--enable-static \
		--enable-runtime-cpu-detect \
		--enable-install-srcs \
		--enable-multi-res-encoding \
		--prefix="$PREFIX" \
	&& make && make install
ghq_get_cd 'https://chromium.googlesource.com/webm/libwebp' \
	&& fancy_cmake -DWEBP_BUILD_CWEBP=ON -DWEBP_BUILD_LIBWEBPMUX=ON -DWEBP_BUILD_WEBPMUX=ON -DWEBP_BUILD_EXTRAS=OFF -DWEBP_BUILD_WEBPINFO=ON -DWEBP_BUILD_DWEBP=ON -DBUILD_SHARED_LIBS=OFF -DWEBP_BUILD_ANIM_UTILS=ON -DWEBP_BUILD_DWEBP=ON -DWEBP_BUILD_VWEBP=OFF
ghq_get_cd 'https://gitlab.freedesktop.org/pixman/pixman.git' \
	&& simple_meson --auto-features=auto --default-library=static -Denable_tests=false -Denable_gtk=false -Dtests=disabled
ghq_get_cd 'https://github.com/libass/libass.git' && env NOCONFIGURE=1 ./autogen.sh && configure_install --enable-static --disable-shared --disable-test --disable-directwrite --disable-coretext
# for the RIST streaming protocol, used in ffmpeg
ghq_get_cd 'https://code.videolan.org/rist/librist.git' && simple_meson -Dtest=false
# build ffmpeg, with the g++ linker to allow linking against libvmaf>=2.0.0 properly
# See https://github.com/Netflix/vmaf/issues/788
ghq_get_cd 'https://git.ffmpeg.org/ffmpeg.git' \
	&& ./configure --prefix="$PREFIX" --bindir="$BINPREFIX" --datadir="$XDG_DATA_HOME" --libdir="$PREFIX/lib" --mandir="$MANPREFIX" \
		--enable-static --disable-shared --disable-debug --arch=x86_64 --cpu=haswell --enable-pic \
		--ld=g++ --extra-libs=-lm --extra-libs=-pthread --enable-lto \
		--enable-version3 \
		--enable-bzlib \
		--disable-crystalhd \
		--enable-fontconfig \
		--enable-frei0r \
		--enable-gcrypt \
		--enable-gnutls \
		--enable-ladspa \
		--enable-librav1e \
		--enable-libaom \
		--enable-libsvtav1 \
		--enable-libdav1d \
		--enable-libass \
		--disable-libcdio \
		--enable-libdrm \
		--enable-libjack \
		--enable-libfreetype \
		--enable-libfribidi \
		--enable-libgsm \
		--disable-cuda-nvcc --disable-cuda-llvm --disable-cuvid --disable-ffnvcodec --disable-nvdec \
		--disable-d3d11va --disable-dxva2 --disable-audiotoolbox \
		--enable-libmp3lame \
		--disable-nvenc \
		--enable-openal \
		--enable-opencl \
		--enable-opengl \
		--enable-libopenjpeg \
		--enable-libopus \
		--enable-libpulse \
		--enable-librsvg \
		--enable-libsoxr \
		--enable-libspeex \
		--enable-libssh \
		--enable-libtheora \
		--enable-libvorbis \
		--enable-libv4l2 \
		--enable-libvidstab \
		--enable-libvmaf \
		--enable-libvpx \
		--enable-libwebp \
		--enable-libx264 \
		--enable-libx265 \
		--enable-libxvid \
		--enable-libzimg \
		--enable-libzvbi \
		--enable-avfilter \
		--enable-postproc \
		--enable-pthreads \
		--enable-librist \
		--enable-gpl \
		--disable-debug \
		--enable-libmfx \
		--enable-runtime-cpudetect \
		--disable-vdpau \
	&& make_install
ghq_get_cd 'https://code.videolan.org/videolan/libplacebo.git' && simple_meson -Dvulkan=enabled -Dshaderc=enabled --default-library=static -Ddemos=false -Dtests=false -Dd3d11=disabled
# neovim dep
ghq_get_cd 'https://github.com/tree-sitter/tree-sitter.git' && make_install
export CFLAGS="$CFLAGS_LTO" LDFLAGS="$CFLAGS_LTO" CXXFLAGS="$CFLAGS_LTO" CPPFLAGS="$CFLAGS_LTO"
# for building statically-linked tmux
ghq_get_cd 'https://github.com/libevent/libevent.git' && ./autogen.sh && configure_install --disable-shared --enable-static

ghq_get_cd https://github.com/AOMediaCodec/libavif.git && fancy_cmake -DAVIF_CODEC_AOM=1 -DAVIF_CODEC_DAV1D=1 -DAVIF_CODEC_RAV1E=1 -DAVIF_CODEC_SVT=1 -DBUILD_SHARED_LIBS=0 -DAVIF_BUILD_APPS=1 -DAVIF_BUILD_GDK_PIXBUF=0 -DAVIF_LIBYUV_ENABLED=1 -DENABLE_CCACHE=0

# waifu2x-ncnn-vulkan
ghq_get_cd https://github.com/nihui/waifu2x-ncnn-vulkan.git \
	&& mkdir -p build && cd build \
	&& cmake ../src -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$CMAKE_INSTALL_PREFIX" -DCMAKE_INSTALL_MANDIR="$CMAKE_INSTALL_MANDIR" \
	&& cmake --build . --target install \
	&& install -m 0755 ./waifu2x-ncnn-vulkan "$BINPREFIX"

# mpv, with ffmpeg/libass statically linked
# shellcheck disable=SC2169
ghq_get_cd https://github.com/mpv-player/mpv-build.git \
	&& /bin/printf '--arch=x86_64\n--enable-version3\n--enable-bzlib\n--disable-crystalhd\n--enable-fontconfig\n--enable-frei0r\n--enable-gcrypt\n--enable-gnutls\n--enable-ladspa\n--enable-libaom\n--enable-libdav1d\n--enable-libass\n--disable-libcdio\n--enable-libdrm\n--enable-libjack\n--enable-libfreetype\n--enable-libfribidi\n--enable-libgsm\n--enable-libmp3lame\n--disable-nvenc\n--enable-openal\n--enable-opencl\n--enable-opengl\n--enable-libopenjpeg\n--enable-libopus\n--enable-libpulse\n--enable-librsvg\n--enable-libsoxr\n--enable-libspeex\n--enable-libssh\n--enable-libtheora\n--enable-libvorbis\n--enable-libv4l2\n--enable-libvidstab\n--enable-libvmaf\n--enable-libvpx\n--enable-libwebp\n--enable-libx264\n--enable-libx265\n--enable-libxvid\n--enable-libzimg\n--enable-libzvbi\n--enable-avfilter\n--disable-avresample\n--enable-postproc\n--enable-pthreads\n--enable-gpl\n--disable-debug\n--enable-libmfx\n--enable-runtime-cpudetect\n--disable-vdpau' >ffmpeg_options \
	&& /bin/printf "--prefix=$PREFIX\n--datarootdir=$CONFIGPREFIX\n--mandir=$MANPREFIX\n--confdir=$CONFIGPREFIX\n--lua=luajit\n--disable-android\n--disable-audiounit\n--disable-caca\n--disable-cdda\n--disable-cocoa\n--disable-coreaudio\n--disable-cuda-hwaccel\n--disable-cuda-interop\n--disable-d3d-hwaccel\n--disable-d3d11\n--disable-d3d9-hwaccel\n--disable-debug-build\n--disable-direct3d\n--disable-dvdnav\n--disable-egl-android\n--disable-egl-angle\n--disable-egl-angle-lib\n--disable-egl-angle-win32\n--disable-egl-x11\n--disable-gl-cocoa\n--disable-gl-dxinterop\n--disable-gl-dxinterop-d3d9\n--disable-gl-win32\n--disable-gl-x11\n--disable-ios-gl\n--disable-libbluray\n--disable-macos-10-11-features\n--disable-macos-10-12-2-features\n--disable-macos-10-14-features\n--disable-macos-cocoa-cb\n--disable-macos-media-player\n--disable-macos-touchbar\n--disable-rpi\n--disable-rpi-mmal\n--disable-sdl2\n--disable-swift\n--disable-tvos\n--disable-vaapi-x-egl\n--disable-vaapi-x11\n--disable-vdpau\n--disable-videotoolbox-gl\n--disable-wasapi\n--disable-win32-internal-pthreads\n--disable-x11\n--disable-xv\n--enable-gl-wayland\n--enable-libarchive\n--enable-libmpv-shared\n--enable-vaapi-wayland\n--enable-wayland\n--enable-wayland-protocols\n--enable-wayland-scanner\n--enable-shaderc\n--enable-vulkan" >mpv_options \
	&& dash ./use-ffmpeg-master && dash ./use-mpv-master && dash ./use-libass-master \
	&& dash ./update && dash ./clean \
	&& dash ./scripts/libass-config && dash ./scripts/libass-build \
	&& cp "$LIBPREFIX/libpixman-1.a" "$LIBPREFIX"/libwebp*.a "$LIBPREFIX/libzstd.a" "$LIBPREFIX/libplacebo.a" ./build_libs/ \
	&& dash ./scripts/ffmpeg-config && dash ./scripts/ffmpeg-build \
	&& install -m 0755 ffmpeg_build/ffmpeg "$BINPREFIX" \
	&& install -m 0755 ffmpeg_build/ffplay "$BINPREFIX" \
	&& install -m 0755 ffmpeg_build/ffprobe "$BINPREFIX" \
	&& export CFLAGS="$CFLAGS_LTO" \
		LDFLAGS="$CFLAGS_LTO" \
		CXXFLAGS="$CFLAGS_LTO" \
		CPPFLAGS="$CFLAGS_LTO"

# i tried a bunch of things, but liblua.a causes problems with programs
# that expect luajit or lua 5.{1,2} so do this horrible hack instead:
# move liblua.a somewhere else, build those programs, and move it back.
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

# wlsunset, much simpler than gammastep/redshift
ghq_get_cd 'https://git.sr.ht/~kennylevinsen/wlsunset' && simple_meson

# minetest
ghq_get_cd 'https://github.com/minetest/minetest.git' \
	&& {
		git -C games/minetest_game pull \
			|| git clone 'https://github.com/minetest/minetest_game.git' games/minetest_game
	} \
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
		-Dbin_programs=true \
		-Dbin_contrib=true \
		--default-library=static \
		builddir \
	&& ninja -C builddir && ninja -C builddir install

# atool
ghq_get_cd https://repo.or.cz/atool.git && simple_autotools

# cxxmatrix: much more advanced than cmatrix
# uses hankaku kana characters + different sahdes + different scenes.
ghq_get_cd https://github.com/akinomyoga/cxxmatrix && make_install

# bcal
ghq_get_cd https://github.com/jarun/bcal.git && make_install

# kitty
ghq_get_cd https://github.com/kovidgoyal/kitty.git \
	&& python3 ./setup.py linux-package --update-check-interval=0 --prefix="$PREFIX"

# dash shell, static binary
# GLOB_NOMAGIC still doesn't seem to be in Fedora's musl libc.
ghq_get_cd https://git.kernel.org/pub/scm/utils/dash/dash.git \
	&& env NOCONFIGURE=1 ./autogen.sh \
	&& CC='musl-gcc -static' CFLAGS="$CFLAGS -static -Os" LDFLAGS="$LDFLAGS -static -Os" simple_autotools --enable-static --disable-glob

# cava - I only use it with MPD FIFO, no need for ALSA/Pulse
ghq_get_cd https://github.com/karlstav/cava.git \
	&& ./autogen.sh \
	&& FONT_DIR="$DATAPREFIX/fonts" configure_install \
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
	&& CFLAGS="$CFLAGS -static" ./autogen.sh \
	&& CFLAGS="$CFLAGS -static" configure_install --enable-static

# another important tool
ghq_get_cd https://github.com/jaseg/lolcat && DESTDIR=$PREFIX/bin make_install

# ncmpcpp, with only the features i use
ghq_get_cd https://github.com/ncmpcpp/ncmpcpp.git \
	&& ./autogen.sh \
	&& configure_install --disable-static --with-taglib

# back to regular flags, no LTO
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"
# stuff that needs LDFLAGS empty
unset LIBLDFLAGS

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
