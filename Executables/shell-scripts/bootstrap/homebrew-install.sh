#!/usr/bin/env bash

# partly based on https://github.com/fabiomaia/linuxify/blob/master/linuxify
formulae=(
	# Missing GNU programs
	"autoconf"
	"gdb"
	"watch"
	"wdiff"
	"wget"
	# GNU equivalents of BSD programs
	"binutils"
	"coreutils"
	"diffutils"
	"ed"
	"findutils"
	"gawk"
	"gnu-indent"
	"gnu-sed"
	"gnu-tar"
	"gnu-which"
	"gnupg"
	"grep"
	"gzip"
	# Outdated GNU progams
	"bash"
	"gpatch"
	"less"
	"m4"
	"make"
	"nano"
	# Outdated BSD programs
	"flex"
	# Docker
	"docker"
	"docker-compose"
	"docker-ls"
	"docker-machine"
	"docker-machine-driver-hyperkit"
	"docker-machine-driver-xhyve"
	# Other
	"abduco"
	"aria2"
	"asciinema"
	"calc"
	"catimg"
	"ccls"
	"cmake"
	"cmatrix"
	"curl"
	"dante"
	"dash"
	"exiftool"
	"ext4fuse"
	"ffmpeg"
	"file-formula"
	"fortune"
	"ghc"
	"go"
	"htop"
	"imagemagick"
	"libressl"
	"lua"
	"luajit"
	"luarocks"
	"ncurses"
	"neovim"
	"nnn"
	"node"
	"nyancat"
	"openssh"
	"openssl"
	"opus"
	"p7zip"
	"pcre"
	"perl"
	"pkg-config"
	"python"
	"redshift"
	"rsync"
	"ruby"
	"rust"
	"sdl"
	"sdl2"
	"shellcheck"
	"stack"
	"tmux"
	"unzip"
	"w3m"
	"x264"
	"x265"
	"yadm"
	"zsh"
)

# shellcheck disable=SC2086
brew install ${formulae[*]}

casks=(
	"firefox-nightly"
	"font-hasklig"
	"font-hasklig-nerd-font"
	"font-noto-color-emoji"
	"font-noto-nerd-font-mono"
	"font-noto-sans"
	"font-noto-serif"
	"font-source-sans-pro"
	"font-source-serif-pro"
	"gimp"
	"icanhazshortcut"
	"keepassxc"
	"keepingyouawake"
	"mactex-no-gui"
	"mpv"
	"mtmr"
	"osxfuse"
	"signal-beta"
	"vimr"
)

# shellcheck disable=SC2086
brew cask install ${casks[*]}

