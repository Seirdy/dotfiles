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
	"adobe-*-fonts"
	"appmenu-qt5"
	"aria2"
	"asciidoc"
	"autoconf"         # build many things
	"autoconf-archive" # building xdg-dbus-proxy
	"automake"         # build things like podman
	"bash-completion"
	"bc"
	"bison" # build many programs' docs
	"breeze-gtk"
	"btrfs-progs-devel" # build podman, skopeo
	"bzip2"
	"calc"  # really small/fast CLI calculator
	"cargo" # rust package manager. used to install itself; then uninstalled.
	"catimg"
	"ccls"                     # C/C++/Objective-C language server
	"chafa"                    # display images with 24bit color unicode in the terminal
	"chromium-browser-privacy" # ungoogled-chromium
	"clang"
	"clang-devel" # build compilers like tinygo
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
	"extra-cmake-modules"
	"ffmpeg-libs"
	"ffmpegthumbnailer" # generates thumbnails from videos, used for file preview
	"firefox-nightly"
	"flatpak-builder"
	"fontawesome-fonts"
	"fontconfig"
	"fontconfig-devel"
	"fontconfig-devel" # build kitty
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
	"glib2-devel" # building many packages including xdg-dbus-proxy and flatpak
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
	"harfbuzz-devel" # build kitty
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
	"keepassxc"       # password manager until I migrate to `pass`
	"latexmk"
	"libXcursor-devel"
	"libXi-devel"
	"libXinerama-devel"
	"libXrandr-devel"
	"libappstream-glib-devel" # build flatpak
	"libarchive-devel"        # build flatpak
	"libassuan-devel"         # building skopeo and others
	"libcap-devel"            # building bubblewrap, slirp4netns
	"libcmocka-devel"
	"libdbusmenu-gtk3" # enable global app menu
	"libmatthew-java"  # signal-cli
	"libpng-devel"     # build imv and others
	"libpng-devel"     # build kitty
	"librsvg2-devel"   # Compiling imv
	"librsvg2-tools"   # work with svg files; used for swaylock icon
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
	"llvm-devel" # build compilers like tinygo
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
	"pciutils" # used by neofetch
	"perl-ExtUtils-Embed"
	"pkgconfig"
	"pkgconfig(json-c)"     # newsboat compilation
	"pkgconfig(libcrypto)"  # newsboat compilation
	"pkgconfig(libcurl)"    # newsboat compilation
	"pkgconfig(libxml-2.0)" # newsboat compilation
	"pkgconfig(ncursesw)"   # newsboat compilation
	"pkgconfig(sqlite3)"    # newsboat compilation
	"pkgconfig(stfl)"       # newsboat compilation
	"plasma-breeze"         # preferred qt5 theme
	"plasma-breeze-common"  # preferred qt5 theme
	"playerctl"
	"polkit-devel" # build flatpak
	"powerline-fonts"
	"pv" # monitor piping
	"python3-devel"
	"python3-libmount"       # building crun
	"python3-matplotlib-qt5" # plotting in python
	"qrencode"
	"qt5-qtmultimedia-devel" # build quotient
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
	"scrot"                # Screenshots on X11
	"selinux-policy-devel" # build flatpak
	"sqlitebrowser"
	"sshfs" # mount another computer
	"stack" # haskell package maanger. Used to download itself; then I uninstall it.
	"startup-notification-devel"
	"strace"   # monitor syscalls during program execution
	"swaybg"   # sway: wallpaper
	"swayidle" # sway: execute commands after idle periods
	"swaylock" # sway: lockscreen
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
