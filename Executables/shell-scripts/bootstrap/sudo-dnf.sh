#!/bin/bash

if ! grep max_parallel_downloads /etc/dnf/dnf.conf >/dev/null; then
	echo "max_parallel_downloads=15" >>/etc/dnf/dnf.conf
fi
dnf copr enable eklitzke/watchman
dnf copr enable petersen/stack
dnf copr enable oleastre/fonts
dnf copr enable rspanton/cpputest
dnf copr enable sichera/fedora
dnf copr enable thelocehiliosan/yadm
dnf copr enable sramanujam/firefox-nightly
dnf copr enable zawertun/kde
dnf copr enable gumieri/sway
dnf copr enable jdoss/wireguard
dnf install "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
dnf install "https://github.com/rpmsphere/noarch/raw/master/r/rpmsphere-release-$(rpm -E %fedora)-1.noarch.rpm" -y
dnf remove python-unversioned-command python2 -y
dnf upgrade --refresh --allowerasing -y
packages=(
	"@fonts"
	"ImageMagick"
	"ImageMagick-devel" # For building chafa
	"ImageMagick-libs"
	"LibRaw"
	"SDL2-devel"
	"SDL2_ttf-devel"
	"abduco"
	"adapta-backgrounds"
	"adobe-*-fonts"
	"appmenu-qt5"
	"aria2"
	"asciidoc"
	"atool" # file extraction util used by stpv
	"autoconf"
	"autoconf"
	"automake"          # build things like podman
	"bash-completion"
	"bc"
	"breeze-gtk"
	"btrfs-progs-devel" # build podman, skopeo
	"calc"
	"cargo"
	"catimg"
	"ccls"
	"clang"
	"cmake"
	"cmake(KDecoration2)"
	"cmake(KF5ConfigWidgets)"
	"cmake(KF5CoreAddons)"
	"cmake(KF5GuiAddons)"
	"cmake(KF5WindowSystem)"
	"cmake(Qt5Core)"
	"cmake(Qt5DBus)"
	"cmake(Qt5Gui)"
	"cmake(Qt5X11Extras)"
	"cmake-data"
	"containernetworking-plugins"
	"containers-common" # build podman, skopeo, buildah
	"cryptsetup"
	"ctags"
	"ctags-etags"
	"curl"
	"dash"
	"dbus-devel"
	"device-mapper-devel" # build podman and others
	"dnf-plugins-core"
	"dnf-plugins-core"  # copr and stuff
	"dolphin-plugins"
	"dvtm"
	"egl-wayland-devel"
	"enchant"
	"exif" # useful for stpv
	"extra-cmake-modules"
	"fedora-toolbox"
	"feh"
	"ffmpeg-libs"
	"ffmpegthumbnailer" # generates thumbnails from videos, used for file preview
	"firefox-nightly"
	"firejail" # sandbox for things like w3m without network access
	"fish"
	"flatpak"
	"flatpak-builder"
	"flatpak-runtime-config"
	"fontawesome-fonts"
	"fontconfig"
	"fontconfig-devel"
	"fortune-mod"
	"fpaste"
	"freeimage-devel"
	"freeimage-devel" # Compiling imv
	"freetype"
	"fuse-overlayfs" # podman runtime dependency
	"gcc"
	"gcc-c++"
	"gcc-gdb-plugin"
	"gdb"
	"gettext"
	"git"
	"git-email"
	"glibc"
	"glibc-all-langpacks"
	"glibc-devel"
	"glibc-headers"
	"glibc-static"
	"gnome-themes"
	"gnome-themes-extra"
	"gnu-free-fonts-common"
	"gnu-free-mono-fonts"
	"golang"
	"google-*-fonts"
	"gpgme-devel" # building skopeo and others
	"grsync"
	"gtk-doc" # for building chafa's docs
	"gtk3-devel"
	"harfbuzz-devel"
	"haskell-platform"
	"hostname"       # required for yadm
	"ht-*-fonts"
	"hunspell-en"
	"hwinfo"
	"iptables"
	"ituomi-hasklig-fonts"
	"java-latest-openjdk-devel"
	"jq"
	"latexmk"
	"libXcursor-devel"
	"libXi-devel"
	"libXinerama-devel"
	"libXrandr-devel"
	"libassuan-devel"   # building skopeo and others
	"libcanberra-devel" # Required to build kitty
	"libcmocka-devel"
	"libdbusmenu-gtk3"
	"libpng-devel"
	"librsvg2-devel" # Compiling imv
	"libseccomp"        # build runc
	"libseccomp-devel"
	"libsodium"
	"libtiff-devel"
	"libtool"
	"libva-utils" # provides commands for verifying that vaapi works
	"libva-vdpau-driver"
	"libwayland-client" # Compiling imv
	"libwayland-egl"    # Compiling imv
	"libxkbcommon-x11-devel"
	"llvm"
	"lua-devel"
	"luajit"
	"luarocks"
	"mesa-libGL-devel"
	"mesa-libGLU-devel"
	"meson"
	"mozilla-fira-mono-fonts"
	"mozilla-fira-sans-fonts"
	"mpc"
	"mpd"
	"mpv"
	"ncdu"
	"ncurses-devel"
	"neofetch"
	"neovim"
	"ninja-build"
	"nmap"
	"nnn"
	"npm"
	"nprokopov-fira-code-fonts"
	"nvi"
	"openssl-devel"
	"ostree-devel" # build runc, skopeo, and others
	"p7zip"
	"p7zip-plugins"
	"papirus-icon-theme"
	"patch"
	"perl-ExtUtils-Embed"
	"perl-Image-ExifTool" # For viewing exif metadata, esp. in stpv
	"pkgconfig"
	"pkgconfig(json-c)"     # newsboat compilation
	"pkgconfig(libcrypto)"  # newsboat compilation
	"pkgconfig(libcurl)"    # newsboat compilation
	"pkgconfig(libxml-2.0)" # newsboat compilation
	"pkgconfig(ncursesw)"   # newsboat compilation
	"pkgconfig(sqlite3)"    # newsboat compilation
	"pkgconfig(stfl)"       # newsboat compilation
	"plasma-browser-integration"
	"plasma-nm"
	"plasma-widget-menubar"
	"plasma-workspace-wayland"
	"podman"
	"podman-docker"
	"powerline-fonts"
	"python3-devel"
	"qt5-qtmultimedia-devel" # compile quotient
	"radeontop"
	"rc"
	"rclone"
	"redshift"
	"rsync"
	"ruby-devel"
	"rubygems"
	"runc"
	"rust-analysis"
	"rust-std-static"
	"scdoc" # Build aerc docs
	"scrot" # Screenshots on X11
	"sqlitebrowser"
	"stack"
	"startup-notification-devel"
	"taglib"
	"tar"
	"terminus-fonts"
	"terminus-fonts-console"
	"texlive-collection-basic"
	"texlive-collection-bibtexextra"
	"texlive-collection-humanities"
	"texlive-collection-langenglish"
	"texlive-collection-latexrecommended"
	"texlive-collection-mathscience"
	"texlive-collection-plaingeneric"
	"texlive-collection-publishers"
	"texlive-collection-xetex"
	"tig"
	"tlp"
	"tmux"
	"tor"      # tor
	"torsocks" # tor
	"transmission-cli"
	"turbojpeg-devel"
	"unzip"
	"vim"
	"vollkorn-fonts"
	"w3m"
	"w3m-img"
	"watchman"
	"wayland-devel"
	"wayland-protocols-devel"
	"wget"
	"which"
	"wireguard-dkms"
	"wireguard-tools"
	"wlc-devel"
	"x264-libs"
	"x265-libs"
	"xbacklight"
	"xdg-desktop-portal"
	"xdg-desktop-portal-kde"
	"xdotool"
	"xsel" # Yank tool; used by yank-cli
	"yacreader"
	"yank" # Good yank tool; works with xsel
	"yarn"
	"zathura"
	"zathura-plugins-all"
	"zathura-zsh-completion"
	"zip"
	"zsh"
)
# shellcheck disable=SC2086
dnf install ${packages[*]} --allowerasing
