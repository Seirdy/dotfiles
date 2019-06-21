#!/bin/sh
dnf copr enable agriffis/neovim-nightly
dnf copr enable eklitzke/watchman
dnf copr enable oleastre/fonts
dnf copr enable petersen/pandoc
dnf copr enable rspanton/cpputest
dnf copr enable sichera/fedora
dnf copr enable thelocehiliosan/yadm
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
# dnf upgrade --refresh --allowerasing -y
dnf install catimg curl dante socksify ShellCheck newsboat luarocks nnn breeze-gtk cargo neovim vim zsh fish dash @fonts bash-completion cryptsetup bc calc golang ctags ctags-etags dvtm abduco screen tmux filelight flatpak flatpak-builder neofetch freetype gcc cmake cmake-data cmake extra-cmake-modules dnf-plugins-core dolphin-plugins enchant feh mpv ffmpeg-libs flatpak-runtime-config fontawesome-fonts fontconfig fontconfig-devel fortune-mod fpaste fzf gcc-c++ gcc-gdb-plugin gdb gettext glibc glibc-all-langpacks glibc-devel glibc-headers glibc-static gnome-themes gnome-themes-extra gnu-free-fonts-common gnu-free-mono-fonts ituomi-hasklig-fonts nprokopov-fira-code-fonts nprokopov-fira-code-fonts mozilla-fira-mono-fonts mozilla-fira-sans-fonts tlp hwinfo hunspell-en iptables java-openjdk-devel gtk3-devel p7zip p7zip-plugins plasma-browser-integration plasma-nm plasma-widget-menubar plasma-workspace-wayland keepassxc llvm clang sqlitebrowser ncdu w3m p7zip pandoc pandoc-citeproc pandoc-pdf papirus-icon-theme zathura zathura-plugins-all zathura-zsh-completion xdg-desktop-portal-kde xdg-desktop-portal powerline-fonts rc rclone rsync grsync rust-std-static rust-analysis taglib tar terminus-fonts libva-vdpau-driver git terminus-fonts-console meson texlive texlive-bibtex texlive-base texlive-caption texlive-ctable texlive-etex texlive-filecontents texlive-latex latexmk texlive-lwarp texlive-pdftex texlive-plain texlive-texlive-en texlive-trimspaces texlive-cite xdotool ruby-devel rubygems redshift perl-ExtUtils-Embed.noarch lua-devel luajit tig transmission-cli aria2 nvi vollkorn-fonts w3m-img watchman wayland-devel wayland-protocols-devel wlc-devel appmenu-qt5 libdbusmenu-gtk3 egl-wayland-devel autoconf startup-notification-devel.x86_64 libsodium openssl-devel wget which x265-libs x264-libs xbacklight xclip xsel yacreader zanshin zip ImageMagick ImageMagick-libs LibRaw adapta-backgrounds google-*-fonts adobe-*-fonts ht-*-fonts ccls "cmake(Qt5Core)" "cmake(Qt5Gui)" "cmake(Qt5DBus)" "cmake(Qt5X11Extras)" "cmake(KF5GuiAddons)" "cmake(KF5WindowSystem)" "cmake(KDecoration2)" "cmake(KF5CoreAddons)" "cmake(KF5ConfigWidgets)" ncurses-devel harfbuzz-devel python3-devel fontconfig-devel libXinerama-devel.x86_64 mesa-libGL-devel.x86_64 libxkbcommon-x11-devel.x86_64 libXi-devel.x86_64 libXrandr-devel.x86_64 libXcursor-devel.x86_64 dbus-devel.x86_64 python3-sphinx asciidoc libpng-devel libtiff-devel SDL2-devel SDL2_ttf-devel freeimage-devel libcmocka-devel turbojpeg-devel yadm radeontop npm yarn --allowerasing
dnf remove python2 python2-pip python2-setuptools python-unversioned-command
