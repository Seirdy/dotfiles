#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"
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
	&& make -j "$threads" \
	&& install -m 0755 ./bwrap "$BINPREFIX/bwrap" \
	&& install -m 0644 bwrap.1 "$HOME/.local/share/man/man1"

# flatpak
ghq_get_cd https://github.com/flatpak/flatpak \
	&& ./autogen.sh \
	&& configure_install --with-system-bubblewrap --with-system-dbus-proxy

ghq_get_cd https://github.com/flatpak/flatpak-builder.git \
	&& ./autogen.sh \
	&& configure_install \
		--enable-docbook-docs \
		--with-dwarf-header=/usr/include/libdwarf

# neovim
ghq_get_cd https://github.com/neovim/neovim.git \
	&& luarocks build --local mpack \
	&& luarocks build --local lpeg \
	&& luarocks build --local inspect \
	&& fancy_cmake \
	&& ninja install

# weechat
ghq_get_cd https://github.com/weechat/weechat.git \
	&& fancy_cmake .. \
		-DCMAKE_BUILD_TYPE=Release \
		-DENABLE_ENCHANT=ON \
		-DENABLE_PHP=OFF \
		-DENABLE_PYTHON3=ON \
		-DENABLE_MAN=ON \
		-DENABLE_JAVASCRIPT=OFF \
		-DCA_FILE=/etc/pki/tls/certs/ca-bundle.crt \
	&& make_install

# ncmpcpp, with only the features i use
ghq_get_cd https://github.com/arybczak/ncmpcpp.git \
	&& ./autogen.sh \
	&& configure_install --disable-static --with-taglib --with-curl

# projectM visualizer
ghq_get_cd https://github.com/projectM-visualizer/projectm.git \
	&& simple_autotools --enable-sdl --enable-threading --enable-pulseaudio
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
	&& make -j "$threads" \
	&& set +e \
	&& make install-strip

# newsboat
ghq_get_cd https://github.com/newsboat/newsboat.git \
	&& make -j "$threads" prefix="$PREFIX" \
	&& make install prefix="$PREFIX"

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
