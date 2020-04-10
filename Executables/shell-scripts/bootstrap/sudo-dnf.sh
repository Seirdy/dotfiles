#!/bin/bash
# fedora has bash installed by default
# this script should be run with superuser/sudo/root permissions
start_time=$(date '+%s')

# dnf can do many parallel downloads
if ! grep max_parallel_downloads /etc/dnf/dnf.conf >/dev/null; then
	echo "max_parallel_downloads=20" >>/etc/dnf/dnf.conf
fi
# Enable rpmfusion-free and copr
dnf install "dnf-plugins-core" "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" -y
dnf module enable sway:rolling
# copr repos
dnf copr enable petersen/stack -y
dnf copr enable oleastre/fonts -y # Hasklig and Fira Code
dnf copr enable sramanujam/firefox-nightly -y
dnf copr enable zawertun/kde -y # latest kde
dnf copr enable gumieri/sway -y
dnf copr enable taocris/musl -y # musl stuff
dnf copr enable jdoss/wireguard -y
dnf upgrade --refresh --allowerasing -y
packages=(
	"@fonts"
	"GConf2-devel" # build redshift
	"LibRaw"
	"SDL2_ttf-devel"
	"abduco"
	"adobe-*-fonts"
	"asciidoc"
	"autoconf"         # build many things
	"autoconf-archive" # building xdg-dbus-proxy
	"automake"         # build things like podman
	"bash-completion"
	"bc"
	"bison"       # build many programs' docs
	"boost-devel" # build ncmpcpp
	"breeze-gtk"
	"btrfs-progs-devel" # build podman, skopeo
	"bzip2"
	"calc"  # really small/fast CLI calculator
	"cargo" # rust package manager. used to install itself; then uninstalled.
	"catimg"
	"ccls"                     # C/C++/Objective-C language server
	"chromium-browser-privacy" # ungoogled-chromium
	"clang"
	"clang-devel" # build compilers like tinygo
	"cmake"
	"cmake-data"
	"cryptsetup"
	"ctags"
	"ctags-etags"
	"curl"
	"curl-devel" # build ncmpcpp
	"dash"
	"dbus-devel"
	"dconf-devel"         # build flatpak
	"desktop-file-utils"  # build alacritty and others
	"device-mapper-devel" # build podman and others
	"dnf-plugins-core"
	"dvtm"
	"egl-wayland-devel"
	"elfutils"
	"enchant"
	"enchant-devel" # build weechat
	"extra-cmake-modules"
	"ffmpegthumbnailer" # generates thumbnails from videos, used for file preview
	"fftw-devel"        # build cava and cli-visualizer
	"firefox-nightly"
	"flatpak-builder"
	"fontawesome-fonts"
	"fontconfig"
	"fontconfig-devel" # build kitty
	"fortune-mod"
	"fpaste"
	"freeimage-devel" # build imv
	"freetype"
	"freetype-devel"
	"fuse-devel"           # build flatpak
	"game-music-emu-devel" # build ffmpeg
	"gcc"
	"gcc-c++"
	"gcc-gdb-plugin"
	"gdb"
	"geoclue2-devel" # build redshift
	"gettext"
	"gettext-devel" # build flatpak, redshift, weechat
	"git"
	"git-email"
	"glib2-devel" # building many packages including xdg-dbus-proxy and flatpak
	"glibc"
	"glibc-all-langpacks"
	"glibc-devel"
	"glibc-headers"
	"glibc-static" # build static programs
	"gmp-static"   # required for building Cabal/Stack packages like Hadolint
	"gnome-themes"
	"gnome-themes-extra"
	"gnu-free-fonts-common"
	"gnu-free-mono-fonts"
	"gnutls-devel"                # build weechat
	"gobject-introspection-devel" # building many packages, including flatpak
	"golang"
	"google-*-fonts"
	"gperf"            # build neovim
	"gperftools-devel" # build i3status-rs
	"gpgme-devel"      # building skopeo and others
	"gsm-devel"        # build ffmpeg
	"gtk-doc"          # building flatpak
	"gtk3-devel"
	"guile-devel"    # build weechat
	"harfbuzz-devel" # build kitty
	"haskell-platform"
	"hostname" # required for yadm
	"ht-*-fonts"
	"http-parser-devel" # build romkatv's libgit2, used in gitstatus/powerlevel10k
	"hunspell-en"
	"hwinfo"
	"icu"             # build imv
	"ilibc-devel"     # build ffmpeg
	"iniparser-devel" # build cava
	"intltool"        # build redshift
	"iptables"        # networking setup
	"ituomi-hasklig-fonts"
	"java-latest-openjdk-devel"
	"jq"
	"json-glib-devel" # build flatpak
	"keepassxc"       # password manager until I migrate to `pass`
	"ladspa-devel"    # build ffmpeg
	"lame-devel"      # build ffmpeg
	"latexmk"
	"libXi-devel"
	"libXinerama-devel"
	"libXrandr-devel"
	"libXxf86vm-devel"
	"libappstream-glib-devel" # build flatpak
	"libarchive-devel"        # build flatpak
	"libassuan-devel"         # building skopeo and others
	"libavc1394-devel"        # build ffmpeg
	"libbs2b-devel"           # build ffmpeg
	"libcap-devel"            # building bubblewrap, slirp4netns
	"libcmocka-devel"
	"libdrm-devel"        # build redshift
	"libdwarf-devel"      # build flatpak-builder
	"libevdev-devel"      # build sway
	"libgcrypt-devel"     # build weechat
	"libjpeg-turbo-devel" # build grim
	"libmatthew-java"     # dep for signal-cli
	"libmodplug-devel"    # build ffmpeg
	"libmpdclient-devel"  # build ncmpcpp and other mpd-related stuff
	"libpng-devel"        # build imv, kitty, and others
	"librsvg2-devel"      # build imv
	"librsvg2-tools"      # work with svg files; used for swaylock icon
	"libseccomp"          # build runc and other tools in the OCI stack
	"libseccomp-devel"    # build runc, slirp4netns, and others
	"libsoup-devel"       # build flatpak
	"libtermkey"          # build neovim
	"libtiff-devel"       # Build imv and others
	"libutempter-devel"   # build tmux
	"libuv-devel"         # build neovim
	"libva-utils"         # provides commands for verifying that vaapi works
	"libva-vdpau-driver"
	"libvterm"          # build neovim
	"libvterm-devel"    # build neovim
	"libwayland-client" # build imv
	"libwayland-egl"    # build imv
	"libxcb-devel"
	"libxkbcommon-x11-devel"
	"lld" # llvm linker, used for LTO in packages containing Rust and C/C++
	"llvm"
	"llvm-devel" # build compilers like tinygo
	"lm_sensors"
	"lua-devel" # build weechat and others
	"luajit"
	"luajit-devel" # build neovim
	"luarocks"
	"lvm2" # handles logical volumes, useful for building containers
	"lzip" # best LZMA-based archiving solution. Works well with tar.
	"mesa-libGL-devel"
	"mesa-libGLU-devel"
	"mesa-libOpenCL"            # build Waifu2x-converter-cpp, ffmpeg
	"moreutils"                 # todo: get needed ones with zinit
	"mozilla-*-fonts"           # muh fonts
	"mpd"                       # best music player
	"msgpack"                   # build neovim
	"msgpack-devel"             # build neovim
	"musl-gcc"                  # build some musl programs
	"nasm"                      # build mvtools
	"ncdu"                      # disk usage analyzer; mostly replaced by nnn -S
	"ncurses-devel"             # build several packages inc. newsboat, tmux
	"ninja-build"               # build tons of packages. Meson is installed using pipx.
	"nmap"                      # network exploration
	"notmuch-devel"             # build i3status-rs
	"npm"                       # eww
	"nprokopov-fira-code-fonts" # muh fonts
	"nvi"                       # in case vi/vim wasn't minimal enough
	"ocl-icd-devel"             # build Waifu2x-converter-cpp, ffmpeg
	"opam"
	"openal-soft-devel" # build ffmpeg
	"opencl-devel"      # build Waifu2x-converter-cpp, ffmpeg
	"opencl-headers"    # build ffmpeg
	"openssl-devel"
	"ostree"
	"ostree-devel" # build runc, skopeo, and others
	"p7zip"
	"p7zip-plugins"
	"pam-devel" # build sway
	"papirus-icon-theme"
	"patch"
	"pavucontrol-qt"
	"pciutils"               # used by neofetch
	"perl(Encode)"           # build mpv
	"perl(Math::BigInt)"     # build mpv
	"perl(Math::BigRat)"     # build mpv
	"perl-ExtUtils-Embed"    # build weechat and others
	"perl-devel"             # build weechat
	"pkgconfig"              # build tons of stuff
	"pkgconfig(ImageMagick)" # build chafa and others
	"pkgconfig(Qt5Core)"     # build projectm
	"pkgconfig(Qt5OpenGL)"   # build projectm
	"pkgconfig(alsa)"        # build mpv, cava
	"pkgconfig(aom)"         # build ffmpeg
	"pkgconfig(caca)"        # build projectm
	"pkgconfig(cairo)"       # build imv
	"pkgconfig(dav1d)"       # build mpv
	"pkgconfig(egl)"
	"pkgconfig(enca)"
	"pkgconfig(ffnvcodec)"
	"pkgconfig(freerdp2)" # build sway (optional)
	"pkgconfig(frei0r)"   # build ffmpeg
	"pkgconfig(gbm)"
	"pkgconfig(gdk-pixbuf-2.0)" # build sway
	"pkgconfig(gl)"
	"pkgconfig(jack)"   # build ffmpeg
	"pkgconfig(json-c)" # build newsboat
	"pkgconfig(lcms2)"
	"pkgconfig(libarchive)" # build mpv and others
	"pkgconfig(libass)"     # build ffmpeg
	"pkgconfig(libavcodec)"
	"pkgconfig(libavfilter)"
	"pkgconfig(libavformat)"
	"pkgconfig(libavutil)"
	"pkgconfig(libcares)"         # build aria2 (enables async DNS resolving or something)
	"pkgconfig(libcdio)"          # build ffmpeg
	"pkgconfig(libcdio_paranoia)" # build ffmpeg
	"pkgconfig(libcrypto)"        # build newsboat
	"pkgconfig(libcurl)"          # build newsboat, weechat
	"pkgconfig(libdrm)"           # build ffmpeg
	"pkgconfig(libevent)"         # build tmux
	"pkgconfig(libguess)"
	"pkgconfig(libjpeg)"
	"pkgconfig(libmfx)"     # build ffmpeg
	"pkgconfig(libopenjp2)" # build ffmpeg
	"pkgconfig(libpcre)"    # build sway
	"pkgconfig(libplacebo)" # build mpv and others
	"pkgconfig(libpulse)"   # build projectM, cava, and cli-visualizer
	"pkgconfig(libquvi-0.9)"
	"pkgconfig(libssh)"  # build ffmpeg
	"pkgconfig(libssh2)" # build aria2 (enables SFTP support)
	"pkgconfig(libswresample)"
	"pkgconfig(libswscale)"
	"pkgconfig(libv4l2)" # build ffmpeg
	"pkgconfig(libva)"
	"pkgconfig(libvmaf)"    # build ffmpeg
	"pkgconfig(libwebp)"    # build ffmpeg
	"pkgconfig(libxml-2.0)" # build newsboat
	"pkgconfig(luajit)"
	"pkgconfig(mujs)"
	"pkgconfig(opencv)"     # build Waifu2x-converter-cpp, ffmpeg
	"pkgconfig(opus)"       # build ffmpeg
	"pkgconfig(pango)"      # build sway
	"pkgconfig(rubberband)" # build mpv
	"pkgconfig(sdl2)"
	"pkgconfig(shaderc)" # build mpv
	"pkgconfig(smbclient)"
	"pkgconfig(soxr)"
	"pkgconfig(speex)"
	"pkgconfig(sqlite3)" # build newsboat
	"pkgconfig(stfl)"    # build newsboat
	"pkgconfig(termkey)" # build neovim
	"pkgconfig(theora)"  # build ffmpeg
	"pkgconfig(twolame)" # build ffmpeg
	"pkgconfig(uchardet)"
	"pkgconfig(vapoursynth)"        # build mpv
	"pkgconfig(vapoursynth-script)" # build mpv
	"pkgconfig(vdpau)"
	"pkgconfig(vidstab)" # build ffmpeg
	"pkgconfig(vorbis)"
	"pkgconfig(vulkan)"
	"pkgconfig(wavpack)" # build ffmpeg
	"pkgconfig(wayland-client)"
	"pkgconfig(wayland-cursor)"
	"pkgconfig(wayland-egl)"
	"pkgconfig(wayland-protocols)"
	"pkgconfig(wayland-scanner)"
	"pkgconfig(winpr2)" # build sway (optional)
	"pkgconfig(x11)"
	"pkgconfig(x264)"       # build ffmpeg. From rpmfusion-free
	"pkgconfig(x265)"       # build ffmpeg. From rpmfusion-free
	"pkgconfig(xcb-errors)" # build sway (optional)
	"pkgconfig(xcb-icccm)"  # build sway (optional)
	"pkgconfig(xext)"
	"pkgconfig(xinerama)"
	"pkgconfig(xkbcommon)"
	"pkgconfig(xrandr)"
	"pkgconfig(xscrnsaver)"
	"pkgconfig(xv)"
	"pkgconfig(zimg)"      # build ffmpeg and others
	"pkgconfig(zlib)"      # build ffmpeg, weechat, and others
	"pkgconfig(zvbi-0.2)"  # build ffmpeg
	"plasma-breeze"        # preferred qt5 theme
	"plasma-breeze-common" # preferred qt5 theme
	"polkit-devel"         # build flatpak
	"powerline-fonts"
	"pv"                     # monitor piping
	"python3-devel"          # building weechat, among others
	"python3-docutils"       # build mpv docs
	"python3-libmount"       # building crun
	"python3-matplotlib-qt5" # plotting in python
	"qrencode"
	"radeontop"
	"rc"
	"readline-devel" # build nnn, ncmpcpp, and others
	"roboto-fontface-fonts"
	"rsync"
	"ruby-devel"
	"rubygems"
	"rust-analysis"
	"rust-std-static"
	"scrot"                # Screenshots on X11
	"selinux-policy-devel" # build flatpak
	"sendemail"            # TODO: get from git using zinit
	"source-highlight"     # build weechat
	"sqlitebrowser"
	"sshfs" # mount another computer
	"stack" # haskell package maanger. Used to download itself; then I uninstall it.
	"startup-notification-devel"
	"strace" # monitor syscalls during program execution
	"taglib"
	"taglib-devel" # build ncmpcpp
	"tar"
	"tcl-devel" # build weechat
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
	"unar"            # FOSS reimplementation of unrar
	"unibilium"       # terminfo parsing and building neovim
	"unibilium-devel" # build neovim
	"unzip"
	"upower" # battery status of connected devices
	"vim"
	"vollkorn-fonts"
	"w3m"
	"w3m-img"
	"waf-python3"
	"wayland-devel"
	"wayland-protocols-devel"
	"wget"
	"which"
	"wireguard-dkms"
	"wireguard-tools"
	"wl-clipboard"
	"wlc-devel"
	"wlroots-devel" # build sway
	"x264-libs"
	"x265-libs"
	"xbacklight"
	"xdg-desktop-portal"
	"xdotool"
	"xmlto"                    # build many programs that use XML, inc. Flatpak
	"xorg-x11-server-Xwayland" # xwayland, for running X apps in Wayland (sway)
	"xsel"                     # Yank tool; used by yank-cli
	"xvidcore-devel"           # build ffmpeg. From rpmfusion-free
	"yajl-devel"               # building crun
	"yank"                     # Good yank tool; works with xsel
	"zathura"
	"zathura-plugins-all"
	"zathura-zsh-completion"
	"zeromq-devel" # build ffmpeg
	"zip"
	"zsh"
)
# shellcheck disable=SC2086
dnf install ${packages[*]} --allowerasing --skip-broken -y

# ssh setup
iptables -I INPUT -p tcp -m tcp --dport 22 -j ACCEPT
iptables -I INPUT -p udp --dport 60000:61000 -j ACCEPT

echo 'Initial bootstrap finished. After running "update-all" successfully, uninstall stack and cargo'

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
