#!/usr/bin/env dash
# Update small programs that are compiled with a C compiler

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"
# shellcheck source=./cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

# mpv-mpris
# update this first; updating it kills all running mpv instances
ghq_get_cd https://github.com/hoyon/mpv-mpris && make_install

# j4-dmenu-desktop
ghq_get_cd 'https://github.com/enkore/j4-dmenu-desktop.git' \
	&& fancy_cmake
# wob
ghq_get_cd 'https://github.com/francma/wob.git' \
	&& meson build-release --buildtype release --prefix "$PREFIX" \
	&& ninja -C build-release \
	&& ninja -C build-release install

# file(1)
ghq_get_cd https://github.com/file/file.git && simple_autotools

# atool
ghq_get_cd https://repo.or.cz/atool.git && simple_autotools

export CFLAGS="$CFLAGS_LTO" \
	LDFLAGS="$CFLAGS_LTO" \
	CXXFLAGS="$CFLAGS_LTO" \
	CPPFLAGS="$CFLAGS_LTO"

# cmatrix
ghq_get_cd https://github.com/abishekvashok/cmatrix.git \
	&& fancy_cmake

# rsync
ghq_get_cd https://git.samba.org/rsync.git \
	&& configure_install --with-included-popt

# imv
ghq_get_cd https://github.com/eXeC64/imv.git \
	&& meson builddir/ \
		--prefix "$PREFIX" \
		--buildtype release \
		--reconfigure \
		--optimization 3 \
		-Dwindows=wayland \
	&& ninja -C builddir/ && ninja -C builddir/ install

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

# mpc: CLI for mpd
ghq_get_cd https://github.com/MusicPlayerDaemon/mpc.git && simple_meson

# playerctl: CLI for mpris and others
ghq_get_cd https://github.com/altdesktop/playerctl.git && simple_meson -Dbash-completions=false

# very important utility; computer basically useless without
ghq_get_cd https://github.com/mtoyoda/sl.git \
	&& make \
	&& install -m0755 sl "$BINPREFIX" \
	&& install -p -m644 sl.1 "$MANPREFIX/man1"

# another important tool
ghq_get_cd https://github.com/jaseg/lolcat && DESTDIR=$PREFIX/bin make_install

# tmux
ghq_get_cd https://github.com/tmux/tmux.git \
	&& ./autogen.sh \
	&& configure_install

prepare_sway() {
	if [ -d ./subprojects/wlroots ]; then
		cd ./subprojects/wlroots && git pull
		cd ../..
	else
		git clone 'https://github.com/swaywm/wlroots.git' ./subprojects/wlroots
	fi
}

# All swaywm components except the `sway` executable itself are built
# from source

# swaywm: install swaybar, swaynag, swaymsg.
ghq_get_cd 'https://github.com/swaywm/sway.git' \
	&& prepare_sway \
	&& simple_meson -Dzsh-completions=false -Dbash-completions=false -Dfish-completions=false

# sway-related utils: grim, slurp, swaybg, swaylock, swayidle, mako, wl-clipboard
ghq_get_cd 'https://github.com/emersion/grim.git' && simple_meson
ghq_get_cd 'https://github.com/emersion/slurp.git' && simple_meson
ghq_get_cd 'https://github.com/swaywm/swaybg.git' && simple_meson
# ghq_get_cd 'https://github.com/swaywm/swaylock.git' && simple_meson
ghq_get_cd 'https://github.com/swaywm/swayidle.git' && simple_meson -Dzsh-completions=false -Dbash-completions=false -Dfish-completions=false
ghq_get_cd 'https://github.com/emersion/mako.git' && simple_meson
ghq_get_cd 'https://github.com/bugaevc/wl-clipboard.git' && simple_meson

# redshift for Wayland
ghq_get_cd 'https://github.com/minus7/redshift.git' \
	&& ./bootstrap \
	&& configure_install --with-systemduserunitdir="$CONFIGPREFIX/systemd/user"

# gitstatus for powerlevel10k
DIR="$GHQ_ROOT/github.com/romkatv"
# adapted from https://github.com/romkatv/gitstatus/blob/master/build.zsh
build_libgit2() {
	ghq_get_cd https://github.com/romkatv/libgit2.git \
		&& mkdir -p build && cd build \
		&& cmake .. \
			-DCMAKE_BUILD_TYPE=Release \
			-DCMAKE_INSTALL_PREFIX="$CMAKE_INSTALL_PREFIX" \
			-DCMAKE_INSTALL_MANDIR="$CMAKE_INSTALL_MANDIR" \
			-DTHREADSAFE=ON \
			-DUSE_BUNDLED_ZLIB=ON \
			-DREGEX_BACKEND=builtin \
			-DBUILD_CLAR=OFF \
			-DUSE_SSH=OFF \
			-DUSE_HTTPS=OFF \
			-DBUILD_SHARED_LIBS=OFF \
			-DUSE_EXT_HTTP_PARSER=OFF \
			-DZERO_NSEC=ON \
			..
}

build_gitstatus() {
	ghq_get_cd https://github.com/romkatv/gitstatus.git \
		&& cxxflags="$CXXFLAGS -I$DIR/libgit2/include -DGITSTATUS_ZERO_NSEC" \
		&& ldflags="$LDFLAGS -L$DIR/libgit2/build -static-libstdc++ -static-libgcc" \
		&& CXXFLAGS=$cxxflags LDFLAGS=$ldflags make \
		&& strip gitstatusd \
		&& target="$BINPREFIX/gitstatusd" \
		&& install -m 0755 gitstatusd "$target" \
		&& echo "built: $target" >&2
}

build_libgit2 && build_gitstatus && echo 'built gitstatus successfully'

# back to regulat flags, no LTO
# shellcheck source=./cc_funcs.sh
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
