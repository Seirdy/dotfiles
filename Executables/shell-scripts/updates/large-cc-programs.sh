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

# slirp4netns: required for many rootless container setups and Flatpak
ghq_get_cd https://github.com/rootless-containers/slirp4netns \
	&& ./autogen.sh \
	&& configure_install

# flatpak
ghq_get_cd https://github.com/flatpak/flatpak \
	&& ./autogen.sh \
	&& configure_install --with-system-bubblewrap --with-system-dbus-proxy

# neovim
ghq_get_cd https://github.com/neovim/neovim.git \
	&& make -j "$threads" CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX -DCMAKE_INSTALL_MANDIR=$CMAKE_INSTALL_MANDIR" \
	&& make install

# newsboat
ghq_get_cd https://github.com/newsboat/newsboat.git \
	&& make -j "$threads" prefix="$PREFIX" \
	&& make install prefix="$PREFIX"

# ncmpcpp, with only the features i use
ghq_get_cd https://github.com/arybczak/ncmpcpp.git \
	&& ./autogen.sh \
	&& configure_install --disable-static --with-taglib --with-curl

# zsh
export zsh_cv_sys_nis=no
ghq_get_cd git://git.code.sf.net/p/zsh/code \
	&& autoreconf -fiv \
	&& sed -e 's|^\.NOTPARALLEL|#.NOTPARALLEL|' -i 'Config/defs.mk.in' \
	&& ./Util/preconfig \
	&& fancy_configure --with-tcsetpgrp --enable-maildir-support --enable-pcre \
	&& make -C Src headers \
	&& make -C Src -f Makemod zshpaths.h zshxmods.h version.h \
	&& make -j "$threads" \
	&& set +e \
	&& make install-strip

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"