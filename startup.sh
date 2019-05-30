#!/bin/dash
# POSIX-compliant startup script
# This script sets environment vars and runs redshift if necessary

# Don't re-run this
if [ "$PROFILE_SET" = 1 ]; then
		exit
fi
SESSION_START=$(date -Iseconds)
export SESSION_START

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
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export QT_PLUGIN_PATH="/usr/lib64/qt5/plugins:$QT_PLUGIN_PATH"
export QT_PLUGIN_PATH="$HOME/.local/lib64/qt5/plugins:$QT_PLUGIN_PATH"

# De-clutter my home folder.
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
export GOPATH="$HOME/Executables/go"
export CARGO_HOME="$HOME/Executables/cargo"
export NPM_PACKAGES="$HOME/Executables/npm-packages"
export WAPM_PACKAGES="$HOME/Executables/wapm"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export GEM_HOME="$HOME/Executables/gem"
export GEM_PATH="$GEM_HOME:/usr/share/gems:/usr/local/share/gems:$GEM_PATH"
export PIPX_HOME="$HOME/Executables/pipx"
export PIPX_BIN_DIR="$HOME/Executables/pipx/bin"
# Set MANPATH
export MANPATH="/usr/share/man:$MANPATH"
export MANPATH="$HOME/.local/man:$MANPATH"
export MANPATH="$PIPX_HOME/venvs/*/share/man:$PIPX_HOME/venvs/*/man:$MANPATH"
export MANPATH="$NPM_PACKAGES/share/man:$MANPATH"
# Set PATH
# PATH="$PATH:$HOME/Executables/anaconda3/bin"       # conda
PATH="$PATH:$CARGO_HOME/bin"                         # cargo
PATH="$PATH:$NPM_PACKAGES/bin"                       # npm
PATH="$PATH:$HOME/.luarocks/bin"                     # luarocks
PATH="$PATH:$GEM_HOME/bin"                           # rubygems
PATH="$PATH:$PIPX_BIN_DIR"                           # pipx
PATH="$PATH:$GOPATH/bin"                             # go
PATH="$PATH:$HOME/.local/bin"                        # local bin
PATH="$PATH:$XDG_DATA_HOME/flatpak/exports/bin"  # flatpak
PATH="$PATH:/var/lib/flatpak/exports/bin"            # more flatpak
PATH="$PATH:$HOME/Executables/fzf/bin"               # fzf
PATH="$PATH:/usr/lib64/qt5/bin"                      # qt programs

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
elif [ "$XDG_SESSION_TYPE" = "x11" ]; then  # Redshift only runs on X
		#  Don't run redshift on GNOME (it has its own Night Light)
		#  Don't run redshift if it's already running.
		if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || pgrep redshift; then
				export REDSHIFT_RUNNING=1
		else
				redshift -l "$LATITUDE:$LONGITUDE" -t 6500:2800 &
		fi
fi

export PROFILE_SET=1
