#!/usr/bin/env dash
# POSIX-compliant startup script
# This script sets environment vars and runs redshift if necessary

# Don't re-run this
if [ "$PROFILE_SET" = 1 ]; then
		exit
fi
# Detect my OS
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     MACHINE='Linux';;
    Darwin*)    MACHINE='Darwin';;
    CYGWIN*)    MACHINE='Cygwin';;
    MINGW*)     MACHINE='MinGw';;
    *)          MACHINE="UNKNOWN:${unameOut}"
esac

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export LC_TIME=en_ZA.UTF-8
export DEFTERM="kitty -1"  # Default terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export NVIM_GTK_PREFER_DARK_THEME=1
export GIT_COLA_ICON_THEME="dark"
export NNN_TMPFILE="$XDG_CACHE_HOME/nnn"
export NNN_TRASH=1
export ABDUCO_SOCKET_DIR="$XDG_DATA_HOME"
export WEECHAT_HOME="$XDG_DATA_HOME/weechat"
export GTK_THEME=Breeze-Dark
export GTK_THEME_VARIANT=dark
export BROWSER=nightly
export GTK_USE_PORTAL=1  # KDE file-picker
export QT_QPA_FLATPAK_PLATFORMTHEME='kde'
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export QT_PLUGIN_PATH="/usr/lib64/qt5/plugins:$QT_PLUGIN_PATH"
export QT_PLUGIN_PATH="$HOME/.local/lib64/qt5/plugins:$QT_PLUGIN_PATH"
export GPG_TTY="$(tty)"

# De-clutter my home folder.
# See https://0x46.net/thoughts/2019/02/01/dotfile-madness/
# See https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# In addition to this spec, I use ~/Executables to keep packages installed by
# 3rd-party package managers.
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export GOPATH="$HOME/Executables/go"
export CARGO_HOME="$HOME/Executables/cargo"
export WAPM_PACKAGES="$HOME/Executables/wapm"
export LUAROCKS_CONFIG="$XDG_CONFIG_HOME/luarocks/config.lua"
export PIPX_HOME="$HOME/Executables/pipx"
export PIPX_BIN_DIR="$HOME/Executables/pipx/bin"
# Keep npm from polluting my $HOME
export NPM_PACKAGES="$HOME/Executables/npm"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# Keep rubygems from polluting my $HOME
# Note that ~/.gem will be created if using --user-install, but it's completely
# disposable.
export GEM_HOME="$HOME/Executables/gem"
export GEM_PATH="$GEM_HOME:/usr/share/gems:/usr/local/share/gems:$GEM_PATH"
export GEM_SPEC_CACHE="$GEM_HOME/specs"
export GEMRC="$XDG_CONFIG_HOME/gem/config"

# Set MANPATH
export MANPATH="/usr/share/man:$MANPATH"
export MANPATH="$HOME/.local/man:$MANPATH"
export MANPATH="$PIPX_HOME/venvs/*/share/man:$PIPX_HOME/venvs/*/man:$MANPATH"
export MANPATH="$NPM_PACKAGES/share/man:$MANPATH"
# Set PATH
# PATH="$PATH:$HOME/Executables/anaconda3/bin"       # conda
PATH="$HOME/.local/bin:$PATH"                        # local bin
PATH="/usr/local/bin:$PATH"                        # local bin
PATH="$CARGO_HOME/bin:$PATH"                         # cargo
PATH="$NPM_PACKAGES/bin:$PATH"                       # npm
PATH="$HOME/Executables/luarocks/bin:$PATH"                     # luarocks
PATH="$GEM_HOME/bin:$PATH"                           # rubygems
PATH="$PIPX_BIN_DIR:$PATH"                           # pipx
PATH="$GOPATH/bin:$PATH"                             # go
PATH="$HOME/Executables/fzf/bin:$PATH"               # fzf

if [ "$MACHINE" = "Linux" ]; then
		PATH="$XDG_DATA_HOME/flatpak/exports/bin:$PATH"      # flatpak
		PATH="/var/lib/flatpak/exports/bin:$PATH"            # more flatpak
		PATH="/usr/lib64/qt5/bin:$PATH"                      # qt programs
elif [ "$MACHINE" = "Darwin" ]; then
		PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

# Dedupe PATH
if [ -n "$ZSH_VERSION" ] || which zsh; then
		PATH=$(zsh -fc "typeset -TU P=$PATH p; echo \$P")
else
		old_PATH=$PATH:; PATH=
		while [ -n "$old_PATH" ]; do
				x=${old_PATH%%:*}       # the first remaining entry
				case $PATH: in
						*:"$x":*) ;;          # already there
						*) PATH=$PATH:$x;;    # not there yet
				esac
				old_PATH=${old_PATH#*:}
		done
		PATH=${PATH#:}
		unset old_PATH x
fi
export PATH


export EDITOR="nvim"
export PAGER="w3m"
export RTV_EDITOR="nvim -c ':set filetype=md'"

# I hid these away in their own file so I could privately update my coords
LATITUDE=$(sed -n 1p "$XDG_DATA_HOME/computer_state/coordinates")
LONGITUDE=$(sed -n 2p "$XDG_DATA_HOME/computer_state/coordinates")

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
		export KITTY_ENABLE_WAYLAND=1
		export EGL_PLATFORM=wayland
		export CLUTTER_BACKEND=wayland
		export QT_QPA_PLATFORM=wayland-egl
		export QT_WAYLAND_FORCE_DPI=physical
		export SDL_VIDEODRIVER=wayland  # Makes imv use wayland backend
		# export GDK_BACKEND="wayland"  # Commented bc some apps aren't ready
elif [ "$XDG_SESSION_TYPE" = "x11" ] || [ "$MACHINE" = "Darwin" ]; then  # Redshift only runs on X
		#  Don't run redshift on GNOME (it has its own Night Light)
		#  Don't run redshift if it's already running.
		if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || pgrep redshift > /dev/null; then
				export REDSHIFT_RUNNING=1
		else
				redshift -l "$LATITUDE:$LONGITUDE" -t 6500:2800 &
		fi
fi

SESSION_START=$(date -Iseconds)
export SESSION_START

export PROFILE_SET=1
