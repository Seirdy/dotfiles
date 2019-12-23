#!/usr/bin/env dash
# Update small programs that are compiled with a C compiler

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"
# shellcheck source=./cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

# mpv-mpris
# update this first; updating it kills all running mpv instances
ghq_get_cd https://github.com/hoyon/mpv-mpris && make_install

# tldr
ghq_get_cd https://github.com/tldr-pages/tldr-cpp-client.git \
	&& make -j "$threads" \
	&& install -m0755 tldr "$BINPREFIX" \
	&& install -p -m644 man/tldr.1 "$MANPREFIX/man1"

# rsync
ghq_get_cd https://git.samba.org/rsync.git \
	&& configure_install --with-included-popt

# crun: container runtime. Better than runc.
ghq_get_cd https://github.com/containers/crun.git \
	&& ./autogen.sh \
	&& configure_install

# j4-dmenu-desktop
ghq_get_cd 'https://github.com/enkore/j4-dmenu-desktop.git' \
	&& fancy_cmake \
	&& make_install
# wob
ghq_get_cd 'https://github.com/francma/wob.git' \
	&& meson build-release --buildtype release --prefix "$PREFIX" \
	&& ninja -C build-release \
	&& ninja -C build-release install

# imv
ghq_get_cd https://github.com/eXeC64/imv.git && make_install

# cmatrix
ghq_get_cd https://github.com/abishekvashok/cmatrix.git \
	&& mkdir -p build \
	&& cd build \
	&& fancy_cmake \
	&& cmake --build . --target install

# bcal
ghq_get_cd https://github.com/jarun/bcal.git && make_install

# scdoc
ghq_get_cd https://git.sr.ht/~sircmpwn/scdoc && make_install

# nnn
ghq_get_cd https://github.com/jarun/nnn.git && make_install

# conmon; necessary for building OCI container stack
# commented out cuz it's causing problems; using version from repos.
# ghq_get_cd https://github.com/containers/conmon.git && make podman -j "$threads"
# catatonit; used as container init system

ghq_get_cd https://github.com/openSUSE/catatonit.git && simple_autotools

# aria2: download accelerator
ghq_get_cd 'https://github.com/aria2/aria2.git' \
	&& aclocal \
	&& simple_autotools --with-ca-bundle='/etc/ssl/certs/ca-bundle.crt'

# file(1)
ghq_get_cd https://github.com/file/file.git && simple_autotools

# atool
ghq_get_cd https://repo.or.cz/atool.git && simple_autotools

# kitty
ghq_get_cd https://github.com/kovidgoyal/kitty.git \
	&& python3 ./setup.py linux-package --update-check-interval=0 --prefix="$PREFIX"

# dash shell
ghq_get_cd https://git.kernel.org/pub/scm/utils/dash/dash.git \
	&& env NOCONFIGURE=1 ./autogen.sh \
	&& fancy_configure \
	&& make -j "$threads" \
	&& make install-strip

# cava
ghq_get_cd https://github.com/karlstav/cava.git \
	&& ./autogen.sh \
	&& configure_install

# cli-visualizer
ghq_get_cd https://github.com/dpayne/cli-visualizer.git \
	&& fancy_cmake \
	&& make_install

# mpdinfo: display current mpd track
ghq_get_cd https://github.com/jduepmeier/mpdinfo.git && make_install

# mpc: CLI for mpd
ghq_get_cd https://github.com/MusicPlayerDaemon/mpc.git && simple_meson

# playerctl: CLI for mpris and others
ghq_get_cd https://github.com/altdesktop/playerctl.git && simple_meson

# very important utility; computer basically useless without
ghq_get_cd https://github.com/mtoyoda/sl.git \
	&& make -j "$threads" \
	&& install -m0755 sl "$BINPREFIX" \
	&& install -p -m644 sl.1 "$MANPREFIX/man1"

# another important tool
ghq_get_cd https://github.com/jaseg/lolcat && DESTDIR=$PREFIX/bin make_install

prepare_sway() {
	if [ -d ./subprojects/wlroots ]; then
		cd ./subprojects/wlroots && git pull
		cd ../..
	else
		git clone 'https://github.com/swaywm/wlroots.git' ./subprojects/wlroots
	fi
}

# swaywm
ghq_get_cd 'https://github.com/swaywm/sway.git' && prepare_sway && simple_meson

# sway-related utils: grim, slurp, swaybg, swaylock, swayidle, mako, wl-clipboard
ghq_get_cd 'https://github.com/emersion/grim.git' && simple_meson
ghq_get_cd 'https://github.com/emersion/slurp.git' && simple_meson
ghq_get_cd 'https://github.com/swaywm/swaybg.git' && simple_meson
# ghq_get_cd 'https://github.com/swaywm/swaylock.git' && simple_meson
ghq_get_cd 'https://github.com/swaywm/swayidle.git' && simple_meson
ghq_get_cd 'https://github.com/emersion/mako.git' && simple_meson
ghq_get_cd 'https://github.com/bugaevc/wl-clipboard.git' && simple_meson

# redshift for Wayland
ghq_get_cd 'https://github.com/minus7/redshift.git' \
	&& ./bootstrap \
	&& configure_install --with-systemduserunitdir="$HOME/.config/systemd/user"

# gitstatus for powerlevel10k
DIR="$GHQ_ROOT/github.com/romkatv"
# adapted from https://github.com/romkatv/gitstatus/blob/master/build.zsh
build_libgit2() {
	ghq get -u https://github.com/romkatv/libgit2.git \
		&& cd "$DIR" \
		&& mkdir -p libgit2 && cd libgit2 \
		&& fancy_cmake \
			-DTHREADSAFE=ON \
			-DUSE_BUNDLED_ZLIB=ON \
			-DREGEX_BACKEND=builtin \
			-DBUILD_CLAR=OFF \
			-DUSE_SSH=OFF \
			-DUSE_HTTPS=OFF \
			-DBUILD_SHARED_LIBS=OFF \
			-DUSE_EXT_HTTP_PARSER=OFF \
			-DZERO_NSEC=ON \
			.. \
		&& make -j "$threads"
}

build_gitstatus() {
	ghq get -u https://github.com/romkatv/gitstatus.git \
		&& cd "$DIR" \
		&& cd gitstatus \
		&& cxxflags="$CXXFLAGS -I$DIR/libgit2/include -DGITSTATUS_ZERO_NSEC" \
		&& ldflags=" -L$DIR/libgit2/build -static-libstdc++ -static-libgcc" \
		&& CXXFLAGS=$cxxflags LDFLAGS=$ldflags make -j "$threads" \
		&& strip gitstatusd \
		&& target="$BINPREFIX/gitstatusd" \
		&& install -m 0755 gitstatusd "$target" \
		&& echo "built: $target" >&2
}

build_libgit2 && build_gitstatus && echo 'built gitstatus successfully'

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
