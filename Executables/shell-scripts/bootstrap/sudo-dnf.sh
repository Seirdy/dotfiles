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
	"automake" # build things like podman
	"bash-completion"
	"bc"
	"bison" # build many programs' docs
	"breeze-gtk"
	"btrfs-progs-devel" # build podman, skopeo
	"bzip2"
	"calc"
	"cargo"
	"catimg"
	"ccls"
	"chafa"
	"clang"
	"clang-devel" # compile compilers like tinygo
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
	"containers-common" # build podman, skopeo, buildah
	"cryptsetup"
	"ctags"
	"ctags-etags"
	"curl"
	"dash"
	"dbus-devel"
	"dconf-devel"         # build flatpak
	"device-mapper-devel" # build podman and others
	"dnf-plugins-core"
	"dolphin-plugins"
	"dvtm"
	"egl-wayland-devel"
	"elfutils"
	"enchant"
	"exif" # useful for stpv
	"extra-cmake-modules"
	"feh"
	"ffmpeg-libs"
	"ffmpegthumbnailer" # generates thumbnails from videos, used for file preview
	"firefox-nightly"
	"flatpak-builder"
	"fontawesome-fonts"
	"fontconfig"
	"fontconfig-devel"
	"fortune-mod"
	"fpaste"
	"freeimage-devel" # Compiling imv
	"freetype"
	"freetype-devel"
	"fuse-devel" # build flatpak
	"gcc"
	"gcc-c++"
	"gcc-gdb-plugin"
	"gdb"
	"gettext"
	"gettext-devel" # build flatpak
	"git"
	"git-email"
	"glibc"
	"glibc-all-langpacks"
	"glibc-devel"
	"glibc-headers"
	"glibc-static"
	"gmp-static" # required for building Cabal/Stack packages like Hadolint
	"gnome-themes"
	"gnome-themes-extra"
	"gnu-free-fonts-common"
	"gnu-free-mono-fonts"
	"gobject-introspection-devel" # building many packages, including flatpak
	"golang"
	"google-*-fonts"
	"gperf"       # neovim dependency
	"gpgme-devel" # building skopeo and others
	"gtk-doc"     # building flatpak
	"gtk3-devel"
	"harfbuzz-devel"
	"haskell-platform"
	"hostname" # required for yadm
	"ht-*-fonts"
	"hunspell-en"
	"hwinfo"
	"iptables" # networking setup
	"ituomi-hasklig-fonts"
	"java-latest-openjdk-devel"
	"jq"
	"json-glib-devel" # build flatpak
	"latexmk"
	"libXcursor-devel"
	"libXi-devel"
	"libXinerama-devel"
	"libXrandr-devel"
	"libappstream-glib-devel" # build flatpak
	"libarchive-devel"        # build flatpak
	"libassuan-devel"         # building skopeo and others
	"libcanberra-devel"       # Required to build kitty
	"libcap-devel"            # building bubblewrap, slirp4netns
	"libcmocka-devel"
	"libdbusmenu-gtk3" # enable global app menu
	"libmatthew-java"  # signal-cli
	"libpng-devel"     # build imv and others
	"librsvg2-devel"   # Compiling imv
	"libseccomp"       # build runc
	"libseccomp-devel" # build runc, slirp4netns, and others
	"libsoup-devel"    # build flatpak
	"libtermkey"       # neovim dependency
	"libtiff-devel"    # Build imv and others
	"libtool"
	"libva-utils" # provides commands for verifying that vaapi works
	"libva-vdpau-driver"
	"libvterm"          # neovim dependency
	"libwayland-client" # Compiling imv
	"libwayland-egl"    # Compiling imv
	"libxcb-devel"
	"libxkbcommon-x11-devel"
	"llvm"
	"llvm-devel" # compile compilers like tinygo
	"lm_sensors"
	"lua-devel"
	"luajit"
	"luarocks"
	"lvm2" # handles logical volumes, useful for building containers
	"mesa-libGL-devel"
	"mesa-libGLU-devel"
	"meson"
	"mozilla-fira-mono-fonts"
	"mpc"
	"mpd"
	"mpv"
	"msgpack" # neovim dependency
	"ncdu"
	"ncurses-devel"
	"neofetch" # installing it from here because it comes loaded with deps
	"ninja-build"
	"nmap" # network exploration
	"npm"
	"nprokopov-fira-code-fonts"
	"nvi"
	"opam"
	"openssl-devel"
	"ostree"
	"ostree-devel" # build runc, skopeo, and others
	"p7zip"
	"p7zip-plugins"
	"papirus-icon-theme"
	"patch"
	"pavucontrol-qt"
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
	"playerctl"
	"polkit-devel" # build flatpak
	"powerline-fonts"
	"pv" # monitor piping
	"python3-devel"
	"python3-libmount"       # building crun
	"python3-matplotlib-qt5" # plotting in python
	"qrencode"
	"qt5-qtmultimedia-devel" # compile quotient
	"radeontop"
	"rc"
	"readline-devel" # build nnn and others
	"redshift"       # gumeri/wayland copr repo has patched version for wayland
	"roboto-fontface-fonts"
	"rsync"
	"ruby-devel"
	"rubygems"
	"rust-analysis"
	"rust-std-static"
	"scdoc"                # Build aerc docs
	"scrot"                # Screenshots on X11
	"selinux-policy-devel" # build flatpak
	"sqlitebrowser"
	"sshfs" # mount another computer
	"stack"
	"startup-notification-devel"
	"strace" # monitor program execution
	"swaybg"
	"swayidle"
	"swaylock"
	"taglib"
	"tar"
	"terminus-fonts"
	"terminus-fonts-console"
	"texlive-collection-basic"            # there are literally thousands of texlive packages
	"texlive-collection-bibtexextra"      # holy hell that's a lot of texlive packages
	"texlive-collection-humanities"       # help
	"texlive-collection-langenglish"      # jesus christ
	"texlive-collection-latexrecommended" # make it stop
	"texlive-collection-mathscience"      # oh my god
	"texlive-collection-plaingeneric"     # why are you like this
	"texlive-collection-publishers"       # do you actually need all of these texlive packages
	"texlive-collection-xetex"            # STAHP
	"tig"                                 # tui for git. TODO: compile from source
	"tlp"                                 # power saving on lappie
	"tmux"
	"tor"      # tor
	"torsocks" # tor
	"turbojpeg-devel"
	"unar"      # FOSS reimplementation of unrar
	"unibilium" # terminfo parsing and neovim dependency
	"unzip"
	"upower" # battery status of connected devices
	"vim"
	"vollkorn-fonts"
	"w3m"
	"w3m-img"
	"watchman" # required for some language servers (like MPLS)
	"wayland-devel"
	"wayland-protocols-devel"
	"wget"
	"which"
	"wireguard-dkms"
	"wireguard-tools"
	"wl-clipboard"
	"wlc-devel"
	"x264-libs"
	"x265-libs"
	"xbacklight"
	"xdg-desktop-portal"
	"xdotool"
	"xmlto" # build many programs that use XML, inc. Flatpak
	"xsel"  # Yank tool; used by yank-cli
	"yacreader"
	"yajl-devel" # building crun
	"yank"       # Good yank tool; works with xsel
	"zathura"
	"zathura-plugins-all"
	"zathura-zsh-completion"
	"zip"
	"zsh"
)
# shellcheck disable=SC2086
dnf install ${packages[*]} --allowerasing --skip-broken -y

# ssh setup
iptables -I INPUT -p tcp -m tcp --dport 22 -j ACCEPT
iptables -I INPUT -p udp --dport 60000:61000 -j ACCEPT

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
