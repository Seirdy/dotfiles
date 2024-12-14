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
if [ -n "$PROFILE_SET" ]; then
	exit
fi

# why is telelmetry opt-out
# if you have to implement telmetry that's opt-out instead of opt-in, please think
# about what you're doing and, if you can, have a conversation about ethical
# concerns with the higher-ups who made the decision.
export DO_NOT_TRACK=1 # https://consoledonottrack.com/
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=1
export HINT_TELEMETRY="off"
export GATSBY_TELEMETRY_OPT_OUT=1
export NEXT_TELEMETRY_DEBUG=1
export NUXT_TELEMETRY_DISABLED=1
export ET_NO_TELEMETRY=1
export INFLUXD_REPORTING_DISABLED=true
export NG_CLI_ANALYTICS=false
export CHOOSENIM_NO_ANALYTICS=1
export POWERSHELL_TELEMETRY_OPTOUT=1 # had to use this once for a class.

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
export LC_TIME=C # 24 hour date
export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
export TZ="America/New_York"
# export TZ="US/Hawaii"
export NVIM_GTK_PREFER_DARK_THEME=1
export GIT_COLA_ICON_THEME='dark'
export XCURSOR_THEME='Adwaita'
export NNN_TMPFILE="$XDG_CACHE_HOME/nnn/lastd"
export NNN_TRASH=1
export ABDUCO_SOCKET_DIR="$XDG_DATA_HOME"
export WEECHAT_HOME="$HOME/.weechat"
export HELM_HOME="$XDG_DATA_HOME/helm"
export GRAFANA_THEME=dark
# used to be Breeze but that causes bugs.
# export GTK_THEME=Adwaita-dark
export GTK_THEME_VARIANT=dark
export CALIBRE_USE_SYSTEM_THEME=1

# disable JIT
export GJS_DISABLE_JIT=1
export JSC_useJIT=false
export JavaScriptCoreUseJIT=0
export QV4_FORCE_INTERPRETER=1
# export SIGNAL_CLI_OPTS='-Xint' # disables JIT but makes it too slow.
# I use a bwrapped FF that can't open external links
# and a shell script that wraps chromium with a bunch of prefs
# export BROWSER=chromium
# export GTK_USE_PORTAL=1 # KDE file-picker
#export QT_QPA_FLATPAK_PLATFORMTHEME='kde'
#export QT_PLUGIN_PATH="/usr/lib64/qt5/plugins:$QT_PLUGIN_PATH"
#export QT_PLUGIN_PATH="$HOME/.local/lib64/qt5/plugins:$QT_PLUGIN_PATH"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/pycache"
export TOOLBOX_PROFILE_DIR="$XDG_DATA_HOME/toolbox"
export KUNST_MUSIC_DIR="$HOME/Music"
export _ZL_HYPHEN=1 # fix for https://github.com/skywind3000/z.lua/wiki/FAQ#how-to-input-a-hyphen---in-the-keyword-

# allow using Mercurial with Python 3
export HGPYTHON3=1
# Disable the golang google proxy
#export GOPROXY=direct

# De-clutter my home folder.
# See https://0x46.net/thoughts/2019/02/01/dotfile-madness/
# See https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# In addition to this spec, I use ~/Executables to keep packages installed by
# 3rd-party package managers.
export INFLUXDB_CONFIG_PATH="$XDG_CONFIG_HOME/influxdb/influxdb.conf"
command -v pkg-config >/dev/null && old_pkgconf_path=":$(pkg-config --variable pc_path pkg-config)"
PKG_CONFIG_PATH="$XDG_DATA_HOME/pkgconfig:$HOME/.local/lib/pkgconfig$old_pkgconf_path"
export DASHT_DOCSETS_DIR="$XDG_DATA_HOME/Zeal/Zeal/docsets"
export PKG_CONFIG_PATH
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
export GNUPGHOME="$HOME/.gnupg"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
export TERMINFO="$HOME/Executables/zsh-bin/share/terminfo"
export TERMINFO_DIRS="$HOME/Executables/zsh-bin/share/terminfo:/usr/share/terminfo"
export GOPATH="$HOME/Executables/go"
# shellcheck disable=SC2086
# if "$GOPATH/sdk/gotip/bin/go" version >/dev/null 2>/dev/null; then
# 	export GOROOT="$GOPATH/sdk/gotip"
# 	export GOTOOLDIR="$GOROOT/pkg/tool/linux_amd64"
# fi
export CARGO_HOME="$HOME/Executables/cargo"
export RUSTUP_HOME="$HOME/Executables/rustup"
export WAPM_PACKAGES="$HOME/Executables/wapm"
export LUAROCKS_CONFIG="$XDG_CONFIG_HOME/luarocks/config.lua"
export PIPX_HOME="$HOME/Executables/pipx"
export PIPX_BIN_DIR="$HOME/Executables/pipx/bin"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export NIMBLE_DIR="$HOME/Executables/nimble"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
# Keep npm from polluting my $HOME
export NPM_PACKAGES="$HOME/Executables/npm"
export PNPM_HOME="$NPM_PACKAGES/bin"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export UNISON="$XDG_DATA_HOME/unison"
export OPAMROOT="$HOME/Executables/opam"
export OPAM_SWITCH_PREFIX="$OPAMROOT/default"
export CAML_LD_LIBRARY_PATH="$OPAM_SWITCH_PREFIX/lib/stublibs:Updated by package ocaml"
export OCAML_TOPLEVEL_PATH="$OPAM_SWITCH_PREFIX/lib/toplevel"
# Keep rubygems from polluting my $HOME
# Note that ~/.gem will be created if using --user-install, but it's completely
# disposable.
export GEM_HOME="$HOME/Executables/gem"
export GEM_PATH="$GEM_HOME:/usr/share/gems:/usr/local/share/gems:$GEM_PATH"
export GEM_SPEC_CACHE="$GEM_HOME/specs"
export GEMRC="$XDG_CONFIG_HOME/gem/config"
export STACK_ROOT="$HOME/Executables/stack"
export GHQ_ROOT="$HOME/Executables/ghq"
export ZPLG_HOME="$HOME/Executables/zinit"
# perl
export PERL_LOCAL_LIB_ROOT="$HOME/Executables/perl5"
export PERL_MB_OPT="--install_base \"$PERL_LOCAL_LIB_ROOT\""
export PERL_MM_OPT="INSTALL_BASE=$PERL_LOCAL_LIB_ROOT"
export PERL5LIB="$PERL_LOCAL_LIB_ROOT/lib/perl5"

# Set XDG_DATA_DIRS
xdgdataadd_head() {
	if ! echo "$XDG_DATA_DIRS" | grep -q "$1" >/dev/null; then
		XDG_DATA_DIRS="$1${XDG_DATA_DIRS:+":$XDG_DATA_DIRS"}"
	fi
}

xdgdataadd_head '/usr/share/kde-settings/kde-profile/default/share'
xdgdataadd_head '/usr/local/share'
xdgdataadd_head '/usr/share'
xdgdataadd_head "$XDG_DATA_HOME"
xdgdataadd_head "$HOME/.local/var/lib/flatpak/exports/share"
xdgdataadd_head "$HOME/.local/share/flatpak/exports/share"

export XDG_DATA_DIRS

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.local/lib/:$HOME/.local/lib64"
export GI_TYPELIB_PATH="$HOME/.local/lib/:$GI_TYPELIB_PATH"

# Set MANPATH
manpathadd_head() {
	if [ -d "$1" ] && ! echo "$MANPATH" | grep -q "$1" >/dev/null; then
		MANPATH="$1${MANPATH:+":$MANPATH"}"
	fi
}
manpathadd_head "/usr/share/man"
manpathadd_head "/usr/local/share/man"
manpathadd_head "$NPM_PACKAGES/share/man"
manpathadd_head "$OPAM_SWITCH_PREFIX/man"
MANPATH="$PIPX_HOME/venvs/*/share/man:$PIPX_HOME/venvs/*/man:$MANPATH"
manpathadd_head "$PERL_LOCAL_LIB_ROOT/man"
manpathadd_head "$HOME/Executables/zsh-bin/share/man"
manpathadd_head "$HOME/.local/man"
manpathadd_head "$HOME/.local/share/man"
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
pathadd_tail '/envs/bin'                      # envs.net
pathadd_head "$GEM_HOME/bin"                  # rubygems (ruby)
pathadd_head "$PERL_LOCAL_LIB_ROOT/bin"       # cpanm (perl)
pathadd_head "$PNPM_HOME"                     # npm (javascript)
pathadd_head "$HOME/Executables/luarocks/bin" # luarocks (lua)
pathadd_head "$PIPX_BIN_DIR"                  # pipx (python)
pathadd_head "$GOPATH/bin"                    # go pacakages
# pathadd_head "$GOPATH/sdk/gotip/bin"                  # golang nightly build
pathadd_head "$NIMBLE_DIR/bin"                        # nim packages
pathadd_head "$STACK_ROOT/bin"                        # stack (haskell)
pathadd_head "$OPAM_SWITCH_PREFIX/bin"                # opam
pathadd_head "$CARGO_HOME/bin"                        # cargo (rust)
pathadd_head "$HOME/Executables/zsh-bin/bin"          # static portable zsh
pathadd_head "$HOME/.local/sbin"                      # local sbin
pathadd_head "$HOME/Executables/shell-scripts/bin"    # my shell scripts
pathadd_head "$HOME/Executables/shell-scripts/mblaze" # my mblaze scripts
pathadd_head "$HOME/.local/bin"                       # local bin
pathadd_tail '/usr/lib/jvm/java/bin' # java
pathadd_head "/tmp/bin"                               # binaries like mpv perform better when in /tmp

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
	[ -z "$TMPDIR" ] && export TMPDIR='/tmp'
fi

export PATH

export TUIR_EDITOR="nvim -c ':set filetype=markdown.pandoc.gfm'"
export TUIR_BROWSER="$BROWSER"
export TUIR_PAGER="less -x 2 -ir"

# Pager options
export PAGER='less'
export LESS="-x 2 -Fir"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

# Preferred editor
EDITOR="$(find_alt nvim vim vi nvi nano emacs)"
export EDITOR

# shellcheck disable=SC2154
if [ "$XDG_SESSION_TYPE" = 'wayland' ] || [ -n "$SWAYSOCK" ] || [ -n "$WAYLAND_DISPLAY" ]; then
	# Waylandify all the thing!!!!
	# Covers apps written with the Qt, GTK, and SDL toolkits

	# if XDG_SESSION_TYPE wasn't set
	export XDG_SESSION_TYPE=wayland
	export EGL_PLATFORM=wayland
	export CLUTTER_BACKEND=wayland
	# Qt apps
	export QT_QPA_PLATFORM=wayland-egl
	export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
	# export QT_WAYLAND_FORCE_DPI=physical # breaks everything on qt 5.15
	# SDL apps
	export SDL_VIDEODRIVER=wayland
	# elementary apps
	export ECORE_EVAS_ENGINE=wayland_egl
	export ELM_ENGINE=wayland_egl
	export ELM_DISPLAY=wl
	export ELM_ACCEL=gl
	# some java apps
	export _JAVA_AWT_WM_NONREPARENTING=1
	export KITTY_ENABLE_WAYLAND=1
	# firefox
	export MOZ_ENABLE_WAYLAND=1
	# use wl-copy with pash, and clear the clipboard after one paste
	export PASH_CLIP='wl-copy -n'
	# some GTK apps.
	# Commented out because (Ungoogled-)Chromium and Electron aren't ready
	# export GDK_BACKEND='wayland'
fi

if [ -n "$SWAYSOCK" ]; then
	export XDG_CURRENT_DESKTOP=sway
	export I3SOCK="$SWAYSOCK"
fi
# set the QT5 theme with qt5ct if I'm not running KDE
# shellcheck disable=SC2154
if [ "$XDG_CURRENT_DESKTOP" != 'KDE' ]; then
	export QT_QPA_PLATFORMTHEME='qt5ct' # todo: change this to "gnome" and set gnome icons/fonts properly
	# export QT_STYLE_OVERRIDE='qt5ct-style'
fi
# Start the gpg-agent if not already running
if ! pgrep -xu "$USER" gpg-agent >/dev/null 2>&1; then
	gpg-connect-agent /bye >/dev/null 2>&1
fi
gpg-connect-agent updatestartuptty /bye >/dev/null
if [ -z "$SSH_AUTH_SOCK" ]; then
	SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
	export SSH_AUTH_SOCK
fi

export FZF_DEFAULT_OPTS='-m --ansi'
export FZF_DEFAULT_COMMAND='rg --files -g ""'

# the pash passsword manager is best girl
# https://github.com/dylanaraps/pash
export PASH_TIMEOUT=5
export PASH_LENGH=255
export PASH_DIR="$XDG_DATA_HOME/pash"
export PASH_KEYID=25A69441
export PASH_PATTERN=' -~' # the first half of the ISO 8859-5
export PASH_PATTERN_SIMPLE='[:punct:][:alnum:]'
export PASH_PATTERN_NOSYMBOL='[:alnum]'

SESSION_START="$(date -Iseconds)"
export SESSION_START

export PROFILE_SET="startup.sh"
