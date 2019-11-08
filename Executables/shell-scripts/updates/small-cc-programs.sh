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
export CFLAGS='-O3 -march=native -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection'
export CXXFLAGS='-O3 -march=native -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection'
export FFLAGS='-O3 -march=native -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -I/usr/lib64/gfortran/modules'
export FCFLAGS='-O3 -march=native -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -I/usr/lib64/gfortran/modules'

threads=$(getconf _NPROCESSORS_ONLN)

fancy_configure() {
	./configure \
		--program-prefix= \
		--prefix="$PREFIX" \
		--exec-prefix="$PREFIX" \
		--bindir="$BINPREFIX" \
		--datadir="$XDG_DATA_HOME" \
		--includedir="$HOME/.local/include" \
		--libdir="$HOME/.local/lib64" \
		--libexecdir="$HOME/.local/libexec" \
		--mandir="$MANPREFIX" \
		--infodir="$HOME/.local/share/info" "$@"
}
# crun: container runtime. Better than runc.
ghq_get_cd https://github.com/containers/crun.git \
	&& ./autogen.sh \
	&& fancy_configure \
	&& make -j "$threads" \
	&& make install

# mpv-mpris
ghq_get_cd https://github.com/hoyon/mpv-mpris && make install

# j4-dmenu-desktop
ghq_get_cd 'https://github.com/enkore/j4-dmenu-desktop.git' \
	&& mkdir -p build \
	&& cd build \
	&& cmake -DCMAKE_INSTALL_PREFIX="$PREFIX" -DCMAKE_BUILD_TYPE=Release .. \
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

# scdoc
ghq_get_cd https://git.sr.ht/~sircmpwn/scdoc && make && make install

# nnn
ghq_get_cd https://github.com/jarun/nnn.git && make && make install

# conmon; necessary for building OCI container stack
ghq_get_cd https://github.com/containers/conmon.git && make podman -j "$threads"

# catatonit; used as container init system
ghq_get_cd https://github.com/openSUSE/catatonit.git \
	&& autoreconf -fi \
	&& ./configure --prefix="$PREFIX" \
	&& make

# xdg-dbus-proxy: runtime dep for flatpak programs
ghq_get_cd https://github.com/flatpak/xdg-dbus-proxy.git \
	&& env NOCONFIGURE=1 ./autogen.sh \
	&& fancy_configure \
	&& make -O -j "$threads" \
	&& make install

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
	&& fancy_configure \
	&& make -j "$threads" && make install

# flatpak
ghq_get_cd https://github.com/flatpak/flatpak \
	&& ./autogen.sh \
	&& fancy_configure --with-system-bubblewrap --with-system-dbus-proxy \
	&& make -j "$threads" \
	&& make install

# kitty
ghq_get_cd https://github.com/kovidgoyal/kitty.git \
	&& python3 ./setup.py linux-package --update-check-interval=0 --prefix="$HOME/.local"

# newsboat
ghq_get_cd https://github.com/newsboat/newsboat.git \
	&& make -j "$threads" prefix="$PREFIX" \
	&& make install prefix="$PREFIX"

# neovim
ghq_get_cd https://github.com/neovim/neovim.git \
	&& make -j "$threads" CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX -DCMAKE_INSTALL_MANDIR=$CMAKE_INSTALL_MANDIR" \
	&& make install

# file(1)
ghq_get_cd https://github.com/file/file.git \
	&& autoreconf -fiv \
	&& fancy_configure \
	&& make -j "$threads" \
	&& make install

# dash shell
ghq_get_cd https://git.kernel.org/pub/scm/utils/dash/dash.git \
	&& env NOCONFIGURE=1 ./autogen.sh \
	&& fancy_configure \
	&& make -O -j "$threads" \
	&& make install-strip

# atool
ghq_get_cd https://repo.or.cz/atool.git \
	&& autoreconf -fiv \
	&& fancy_configure \
	&& make -j "$threads" \
	&& make install

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

# gitstatus for powerlevel10k
DIR="$GHQ_ROOT/github.com/romkatv"
# adapted from https://github.com/romkatv/gitstatus/blob/master/build.zsh
build_libgit2() {
	ghq get -u https://github.com/romkatv/libgit2.git \
		&& cd "$DIR" \
		&& mkdir -p libgit2/build \
		&& cd libgit2/build \
		&& cmake \
			-DCMAKE_BUILD_TYPE=Release \
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
		&& local target="$BINPREFIX/gitstatusd" \
		&& install -m 0755 gitstatusd "$target" \
		&& echo "built: $target" >&2
}

build_libgit2 && build_gitstatus && echo 'built gitstatus successfully'

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
