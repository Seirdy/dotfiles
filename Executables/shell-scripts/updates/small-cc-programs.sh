#!/usr/bin/env dash
# Update small programs that are compiled with a C compiler

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"

export PREFIX="$HOME/.local"
export BINPREFIX="$PREFIX/bin"
export MANPREFIX="$PREFIX/man"
export DATAPREFIX="$PREFIX/share"
export CONFIGPREFIX="$HOME/.config"
export CONFIGPREFIX="$HOME/.config"
export CMAKE_INSTALL_PREFIX="$PREFIX"
export CMAKE_INSTALL_MANDIR="$MANPREFIX"

export LIBLDFLAGS='-z lazy'
export CFLAGS='-O3 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection'
export CXXFLAGS='-O3 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection'
export FFLAGS='-O3 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -I/usr/lib64/gfortran/modules'
export FCFLAGS='-O3 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -I/usr/lib64/gfortran/modules'
export LDFLAGS='-Wl,-z,relro -Wl,--as-needed  -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld'

# crun: container runtime. Better than runc.
ghq_get_cd https://github.com/containers/crun.git \
	&& ./autogen.sh \
	&& ./configure --prefix="$PREFIX" \
	&& make \
	&& make install

# mpv-mpris
ghq_get_cd https://github.com/hoyon/mpv-mpris && make install

ghq_get_cd 'https://github.com/enkore/j4-dmenu-desktop.git' \
	&& mkdir -p build \
	&& cd build \
	&& cmake -DCMAKE_INSTALL_PREFIX=/home/rkumar/.local -DCMAKE_BUILD_TYPE=Release .. \
	&& make \
	&& make install

# imv
ghq_get_cd https://github.com/eXeC64/imv.git && make && make install

# cmatrix
ghq_get_cd https://github.com/abishekvashok/cmatrix.git \
	&& mkdir -p build \
	&& cd build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX="$PREFIX" -DCMAKE_BUILD_TYPE=Release \
	&& cmake --build . --target install

# bcal
ghq_get_cd https://github.com/jarun/bcal.git && make && make install

# nnn
ghq_get_cd https://github.com/jarun/nnn.git && make && make install

# conmon; necessary for building OCI container stack
ghq_get_cd https://github.com/containers/conmon.git && make podman

# catatonit; used as container init system
ghq_get_cd https://github.com/openSUSE/catatonit.git \
	&& autoreconf -fi \
	&& ./configure --prefix="$PREFIX" \
	&& make

# xdg-dbus-proxy: runtime dep for flatpak programs
ghq_get_cd https://github.com/flatpak/xdg-dbus-proxy.git \
	&& env NOCONFIGURE=1 ./autogen.sh \
	&& ./configure --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu --program-prefix= --prefix="$PREFIX" --exec-prefix="$PREFIX" --bindir="$BINPREFIX" --datadir="$XDG_DATA_HOME" --includedir="$HOME/.local/include" --libdir="$HOME/.local/lib64" --libexecdir="$HOME/.local/libexec" --mandir="$MANPREFIX" --infodir="$HOME/.local/share/info" \
	&& make -O -j6 \
	&& make install

# bubblewrap: sandbox any command. Dependency of Flatpak
ghq_get_cd https://github.com/containers/bubblewrap.git \
	&& env NOCONFIGURE=1 ./autogen.sh \
	&& ./configure --prefix="$PREFIX" --libdir="$PREFIX/lib64" \
	&& make \
	&& install -m 0755 ./bwrap "$BINPREFIX/bwrap" \
	&& install -m 0644 bwrap.1 "$HOME/.local/share/man/man1"

# slirp4netns: required for many rootless container setups and Flatpak
ghq_get_cd https://github.com/rootless-containers/slirp4netns \
	&& ./autogen.sh \
	&& ./configure --prefix="$PREFIX" \
	&& make && make install

# flatpak
ghq_get_cd https://github.com/flatpak/flatpak \
	&& ./autogen.sh \
	&& LDFLAGS='' ./configure --prefix="$HOME/.local" --with-system-bubblewrap --with-system-dbus-proxy \
	&& LDFLAGS='' make \
	&& LDFLAGS='' make install

# kitty
ghq_get_cd https://github.com/kovidgoyal/kitty.git \
	&& python3 ./setup.py linux-package --update-check-interval=0 \
	&& cp -r ./linux-package/* "$PREFIX"

# newsboat
ghq_get_cd https://github.com/newsboat/newsboat.git \
	&& make prefix="$PREFIX" \
	&& make install prefix="$PREFIX"

# neovim
ghq_get_cd https://github.com/neovim/neovim.git \
	&& make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX -DCMAKE_INSTALL_MANDIR=$CMAKE_INSTALL_MANDIR" \
	&& make install

# zsh
export zsh_cv_sys_nis=no
ghq_get_cd git://git.code.sf.net/p/zsh/code \
	&& autoreconf -fiv \
	&& sed -e 's|^\.NOTPARALLEL|#.NOTPARALLEL|' -i 'Config/defs.mk.in' \
	&& ./Util/preconfig \
	&& ./configure \
		--prefix="$PREFIX" \
		--mandir="$MANPREFIX" \
		--bindir="$BINPREFIX" \
		--build=x86_64-redhat-linux-gnu \
		--host=x86_64-redhat-linux-gnu \
		--with-tcsetpgrp --enable-maildir-support --enable-pcre \
	&& make -C Src headers \
	&& make -C Src -f Makemod zshpaths.h zshxmods.h version.h \
	&& make -j6 \
	&& set +e \
	&& make install-strip

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
