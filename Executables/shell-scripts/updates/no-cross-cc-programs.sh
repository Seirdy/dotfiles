#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=/home/rkumar/.config/shell_common/functions_ghq.sh
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

# mpv-mpris
# update this first; updating it kills all running mpv instances
ghq_get_cd https://github.com/hoyon/mpv-mpris && make_install

# j4-dmenu-desktop
ghq_get_cd 'https://github.com/enkore/j4-dmenu-desktop.git' \
	&& fancy_cmake ""

# shellcheck disable=SC2154
# icmake is required to build yodl, which is required to build rsync docs
ghq_get_cd https://gitlab.com/fbb-git/icmake \
	&& cd ./icmake \
	&& ./icm_prepare / \
	&& ./icm_bootstrap x \
	&& mkdir -p /tmp/icmake && ln -s "$PREFIX" /tmp/icmake/usr \
	&& ./icm_install strip all /tmp/icmake

# yodl is required to build rsync docs
ghq_get_cd https://gitlab.com/fbb-git/yodl \
	&& cd ./yodl \
	&& for module in programs macros man; do
		CXXFLAGS="$CXXFLAGS -std=c++2a" icmake -qt/tmp/yodl ./build "$module"
		icmake -qt/tmp/yodl ./build install "$module" /tmp/icmake
	done

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

ghq_get_cd https://github.com/flatpak/flatpak-builder.git \
	&& ./autogen.sh \
	&& configure_install \
		--enable-docbook-docs \
		--with-dwarf-header=/usr/include/libdwarf

# projectM visualizer
ghq_get_cd https://github.com/projectM-visualizer/projectm.git \
	&& simple_autotools --enable-sdl --enable-threading --enable-pulseaudio

export CFLAGS="$CFLAGS_LTO" \
	LDFLAGS="$CFLAGS_LTO" \
	CXXFLAGS="$CFLAGS_LTO" \
	CPPFLAGS="$CFLAGS_LTO"

# neovim
ghq_get_cd https://github.com/neovim/neovim.git \
	&& luarocks build --local mpack \
	&& luarocks build --local lpeg \
	&& luarocks build --local inspect \
	&& fancy_cmake -DUSE_BUNDLED=OFF -DENABLE_LTO=ON

# imv
ghq_get_cd https://github.com/eXeC64/imv.git \
	&& meson builddir/ \
		--prefix "$PREFIX" \
		--buildtype release \
		--reconfigure \
		--optimization 3 \
		-Dwindows=wayland \
	&& ninja -C builddir/ && ninja -C builddir/ install

# scdoc
ghq_get_cd https://git.sr.ht/~sircmpwn/scdoc && make_install

# conmon; necessary for building OCI container stack
# commented out cuz it's causing problems; using version from repos.
# ghq_get_cd https://github.com/containers/conmon.git && make podman -j "$threads"
# catatonit; used as container init system

# mpc: CLI for mpd
ghq_get_cd https://github.com/MusicPlayerDaemon/mpc.git && simple_meson

# playerctl: CLI for mpris and others
ghq_get_cd https://github.com/altdesktop/playerctl.git && simple_meson -Dbash-completions=false

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

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
