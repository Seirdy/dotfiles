#!/bin/bash

start_time=$(date '+%s')

# dnf can do many parallel downloads
if ! grep max_parallel_downloads /etc/dnf/dnf.conf >/dev/null; then
	echo "max_parallel_downloads=20" >>/etc/dnf/dnf.conf
fi
# Enable rpmfusion-free and copr
dnf install "dnf-plugins-core" "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" -y
# copr repos
dnf copr enable eklitzke/watchman -y
dnf copr enable petersen/stack -y
dnf copr enable oleastre/fonts -y # Hasklig and Fira Code
dnf copr enable sramanujam/firefox-nightly -y
dnf copr enable zawertun/kde -y # latest kde
dnf copr enable gumieri/sway -y
dnf copr enable jdoss/wireguard -y
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
	"automake" # build things like podman
	"bash-completion"
	"bc"
	"breeze-gtk"
	"btrfs-progs-devel" # build podman, skopeo
	"bzip2"
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
	"gperf"       # neovim dependency
	"gpgme-devel" # building skopeo and others
	"grsync"
	"gtk-doc" # for building chafa's docs
	"gtk3-devel"
	"harfbuzz-devel"
	"haskell-platform"
	"hostname" # required for yadm
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
	"libseccomp"     # build runc
	"libseccomp-devel"
	"libsodium"
	"libtermkey" # neovim dependency
	"libtiff-devel"
	"libtool"
	"libva-utils" # provides commands for verifying that vaapi works
	"libva-vdpau-driver"
	"libvterm"          # neovim dependency
	"libwayland-client" # Compiling imv
	"libwayland-egl"    # Compiling imv
	"libxkbcommon-x11-devel"
	"llvm"
	"lua-devel"
	"luajit"
	"luarocks"
	"lvm2" # handles logical volumes, useful for building containers
	"mesa-libGL-devel"
	"mesa-libGLU-devel"
	"meson"
	"mozilla-fira-mono-fonts"
	"mozilla-fira-sans-fonts"
	"mpc"
	"mpd"
	"mpv"
	"msgpack" # neovim dependency
	"ncdu"
	"ncurses-devel"
	"neofetch" # installing it from here because it comes loaded with deps
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
	"unibilium" # terminfo parsing and neovim dependency
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
	"zathura"
	"zathura-plugins-all"
	"zathura-zsh-completion"
	"zip"
	"zsh"
)
# shellcheck disable=SC2086
dnf install ${packages[*]} --allowerasing --skip-broken -y

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
