#!/usr/bin/env dash

# My startup script, ideally run at the start of my session by my login shell.
# This script sets environment vars and runs redshift if necessary

# Everything except the shebang should be quite portable and POSIX-compliant, though
# there are specific bits only for Linux and macOS.

# TODO: Add support for the following (in no particular order):
#	- {Free,Open}BSD
#	- Debian and derivatives
#	- Arch (btw)
#	- Void Linux
#	- NixOS
#	- TempleOS (fight me)

# Don't re-run this
echo 'setting profile'
if [ "$PROFILE_SET" = 1 ]; then
	exit
fi
find_alt() {
	for i; do
		command -v "$i" >/dev/null && {
			echo "$i"
			return 0
		}
	done
	return 1
}
# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export XDG_USER_CONFIG_DIR="$XDG_CONFIG_HOME" # rofi
export LC_TIME=en_ZA.UTF-8
export TERMINAL="st" # Default terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export NVIM_GTK_PREFER_DARK_THEME=1
export GIT_COLA_ICON_THEME="dark"
export NNN_TMPFILE="$XDG_CACHE_HOME/nnn/lastd"
export NNN_TRASH=1
export ABDUCO_SOCKET_DIR="$XDG_DATA_HOME"
export WEECHAT_HOME="$XDG_DATA_HOME/weechat"
export HELM_HOME="$XDG_DATA_HOME/helm"
export GRAFANA_THEME=dark
export GTK_THEME=Breeze-Dark
export GTK_THEME_VARIANT=dark
export BROWSER=firefox-nightly
export GTK_USE_PORTAL=1 # KDE file-picker
export QT_QPA_FLATPAK_PLATFORMTHEME='kde'
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export QT_PLUGIN_PATH="/usr/lib64/qt5/plugins:$QT_PLUGIN_PATH"
export QT_PLUGIN_PATH="$HOME/.local/lib64/qt5/plugins:$QT_PLUGIN_PATH"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/pycache"
# Disable the golang google proxy
export GOPROXY=direct

# De-clutter my home folder.
# See https://0x46.net/thoughts/2019/02/01/dotfile-madness/
# See https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# In addition to this spec, I use ~/Executables to keep packages installed by
# 3rd-party package managers.
export INFLUXDB_CONFIG_PATH="$XDG_CONFIG_HOME/influxdb/influxdb.conf"
export INFLUXDB_DATA_DIR="$XDG_DATA_HOME/influxdb/data"
export INFLUXDB_DATA_WAL_DIR="$XDG_DATA_HOME/influxdb/wal"
export INFLUXDB_META_DIR="$XDG_DATA_HOME/influxdb/meta"
export GF_PATHS_LOGS="$XDG_DATA_HOME/grafana/logs"
export GF_PATHS_DATA="$XDG_DATA_HOME/grafana/data"
export GF_PATHS_plugins="$XDG_DATA_HOME/grafana/plugins"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
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
export STACK_YAML="$XDG_CONFIG_HOME/stack/stack.yaml"
export STACK_ROOT="$HOME/Executables/stack"
export GHQ_ROOT="$HOME/Executables/ghq"

# Set MANPATH
manpathadd_head() {
	if [ -d "$1" ] && ! echo "$MANPATH" | grep -q "$1" >/dev/null; then
		MANPATH="$1${MANPATH:+":$MANPATH"}"
	fi
}
manpathadd_head "/usr/share/man"
manpathadd_head "/usr/local/share/man"
manpathadd_head "$HOME/.local/man"
manpathadd_head "$HOME/.local/share/man"
manpathadd_head "$NPM_PACKAGES/share/man"
MANPATH="$PIPX_HOME/venvs/*/share/man:$PIPX_HOME/venvs/*/man:$MANPATH"
export MANPATH
export INFOPATH="/usr/local/share/info:$INFOPATH"
# Set PATH

# These functions add a directory to $PATH if it exists and it isn't already there.
pathadd_head() {
	if [ -d "$1" ] && ! echo "$PATH" | grep -q "$1" >/dev/null; then
		PATH="$1${PATH:+":$PATH"}"
	fi
}
pathadd_tail() {
	if [ -d "$1" ] && ! echo "$PATH" | grep -q "$1" >/dev/null; then
		PATH="${PATH:+"$PATH:"}$1"
	fi
}
pathadd_tail '/usr/local/sbin'
pathadd_tail '/usr/local/bin'
pathadd_tail '/usr/sbin'
pathadd_tail '/usr/bin'
pathadd_tail '/sbin'
pathadd_tail '/bin'
pathadd_head "$GEM_HOME/bin"                  # rubygems (ruby)
pathadd_head "$NPM_PACKAGES/bin"              # npm (javascript)
pathadd_head "$HOME/Executables/luarocks/bin" # luarocks (lua)
pathadd_head "$PIPX_BIN_DIR"                  # pipx (python)
pathadd_head "$GOPATH/bin"                    # go
pathadd_head "$GOPATH/sdk/gotip/bin"          # go
pathadd_head "$STACK_ROOT/bin"                # stack (haskell)
pathadd_head "$CARGO_HOME/bin"                # cargo (rust)
pathadd_head "$HOME/.local/bin"               # local bin

# Detect my OS
unameOut="$(uname -s)"
case "${unameOut}" in
	Linux*) MACHINE='Linux' ;;
	Darwin*) MACHINE='Darwin' ;;
	CYGWIN*) MACHINE='Cygwin' ;;
	MINGW*) MACHINE='MinGw' ;;
	*) MACHINE="UNKNOWN:${unameOut}" ;;
esac
export MACHINE

if [ "$MACHINE" = 'Linux' ]; then
	pathadd_tail '/usr/lib64/qt5/bin'                 # qt programs
	pathadd_head "$XDG_DATA_HOME/flatpak/exports/bin" # flatpak (user)
	pathadd_tail '/var/lib/flatpak/exports/bin'       # flatpak (global)
	if [ -z "$TMPDIR" ]; then
		export TMPDIR="/tmp"
	fi
elif [ "$MACHINE" = "Darwin" ]; then
	# override macOS defaults with up-to-date/familiar versions
	pathadd_head '/usr/local/opt/ruby/bin'
	pathadd_head '/usr/local/opt/unzip/bin'
	# A whole GNU $PAAAAAAAAATH!
	pathadd_head '/usr/local/opt/binutils/bin'
	pathadd_head '/usr/local/opt/coreutils/libexec/gnubin'
	pathadd_head '/usr/local/opt/ed/libexec/gnubin'
	pathadd_head '/usr/local/opt/findutils/libexec/gnubin'
	pathadd_head '/usr/local/opt/gnu-indent/libexec/gnubin'
	pathadd_head '/usr/local/opt/gnu-sed/libexec/gnubin'
	pathadd_head '/usr/local/opt/gnu-tar/libexec/gnubin'
	pathadd_head '/usr/local/opt/gnu-which/libexec/gnubin'
	pathadd_head '/usr/local/opt/grep/libexec/gnubin'
	pathadd_head '/usr/local/opt/make/libexec/gnubin'
	pathadd_head '/usr/local/opt/file-formula/bin'
	pathadd_head '/usr/local/opt/gettext/bin'
	pathadd_head '/usr/local/opt/libxml2/lib/pkgconfig'
	pathadd_head '/usr/local/opt/sqlite/bin'
	export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

export PATH

export TUIR_EDITOR="nvim -c ':set filetype=pandoc'"
export TUIR_BROWSER="$BROWSER"
export TUIR_PAGER="less -x 2 -ir"

# Pager options
export PAGER='less'
export LESS="-x 2 -Fir"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

# Preferred editor
EDITOR=$(find_alt nvim vim vi nvi nano emacs)
export EDITOR

if [ "$XDG_SESSION_TYPE" = 'wayland' ]; then
	export KITTY_ENABLE_WAYLAND=1
	export EGL_PLATFORM=wayland
	export CLUTTER_BACKEND=wayland
	export QT_QPA_PLATFORM=wayland-egl
	export QT_WAYLAND_FORCE_DPI=physical
	export SDL_VIDEODRIVER=wayland # Makes imv use wayland backend
	export TERMINAL='kitty -1'
	# export GDK_BACKEND="wayland"  # Commented bc some apps aren't ready
elif [ "$XDG_SESSION_TYPE" = 'x11' ] || [ "$MACHINE" = 'Darwin' ] && [ "$REDSHIFT_RUNNING" != 1 ]; then
	#  Don't run redshift on GNOME (it has its own Night Light)
	#  Don't run redshift on Wayland
	#  Don't run redshift if it's already running.
	if [ "$XDG_CURRENT_DESKTOP" = 'GNOME' ] || pgrep redshift >/dev/null; then
		export REDSHIFT_RUNNING=1
	elif command -v redshift; then
		latitude=$(sed -n 1p "$XDG_DATA_HOME/computer_state/coordinates")
		longitude=$(sed -n 2p "$XDG_DATA_HOME/computer_state/coordinates")
		redshift -l "$latitude:$longitude" -t 6500:2800 &
	else
		echo 'redshift not found. Install redshift to warm your screen at night.'
	fi
fi

SESSION_START="$(date -Iseconds)"
export SESSION_START
export FZF_DEFAULT_OPTS='-m --ansi'
export FZF_DEFAULT_COMMAND='rg --files -g ""'

export PROFILE_SET=1
