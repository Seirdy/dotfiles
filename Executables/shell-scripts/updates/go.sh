#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=./cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"
if "$GOPATH/sdk/gotip/bin/go" version >/dev/null; then
	export GOROOT="$GOPATH/sdk/gotip"
	export GOTOOLDIR="$GOROOT/pkg/tool/linux_amd64"
fi
# sometimes go.mod and go.sum files change locally, preventing a pull; reset to fix.
go_update() {
	echo "###"
	echo "### Updating $* ###"
	echo "###"
	cd "$GOPATH/src/$1" && git reset --hard HEAD && cd - || echo "$1 doesn't seem to be installed yet."
	go get -u -v "$*" 2>&1 # verbose output is sent to stderr for some reason
}
go_update github.com/McKael/madonctl
# building docs for some golang packages
go_update github.com/cpuguy83/go-md2man
# Critical programs for my workflow; computer is useless without them
go_update github.com/Code-Hex/Neo-cowsay/cmd/cowsay
go_update github.com/Code-Hex/Neo-cowsay/cmd/cowthink
# If htop wasn't pretty enough
go_update github.com/cjbassi/gotop
# fzf
go_update github.com/junegunn/fzf \
	&& install -p -m644 "$GOPATH"/src/github.com/junegunn/fzf/man/man1/* "$MANPREFIX/man1"
# Test dl speed
go_update github.com/ddo/fast
# alternate pager
go_update github.com/walles/moar
# Quickly share files between computers
GO111MODULE=on go_update github.com/schollz/croc/v6
# Pager for log files
go_update github.com/tigrawap/slit/cmd/slit
# shell script formatter
GO111MODULE=on go_update mvdan.cc/sh/v3/cmd/shfmt
# like jq but for yaml
GO111MODULE=on go_update github.com/mikefarah/yq/v2
# curlie: better than httpie
go_update github.com/rs/curlie
# profile (neo)vim startuptime
go_update github.com/rhysd/vim-startuptime
# url pickers
go_update mvdan.cc/xurls/cmd/xurls
go_update github.com/imwally/linkview
# corrupts images for fancy lockscreen
go_update github.com/r00tman/corrupter
# Alternative terminal emulator
# github.com/liamg/aminal
# Advanced file manager (like ranger)
go_update github.com/gokcehan/lf
# github and gitlab CLI
go_update github.com/github/hub
go_update github.com/zaquestion/lab || echo "failed to install lab"
# used to clone repos into a nice directory tree like "go get" does
GO111MODULE=on go_update github.com/x-motemen/ghq
# extra commands for ghq
go_update github.com/uetchy/gst
# matrix client, for when I get bored of weechat-matrix
go_update github.com/tulir/gomuks
# MPRIS bridge for MPD
go_update github.com/natsukagami/mpd-mpris/cmd/mpd-mpris
# dictionary CLI
go_update github.com/Rican7/define

# Development tools
#

# More strict than gofmt
go_update mvdan.cc/gofumpt
go_update mvdan.cc/gofumpt/gofumports
# Dependency graph
go_update github.com/kisielk/godepgraph
# best sloc cloc and code counter
go_update github.com/boyter/scc
# language server
go_update golang.org/x/tools/gopls
# Learn go
go_update golang.org/x/tour
# godoc webserver
go_update golang.org/x/tools/cmd/godoc
# linting
go_update github.com/golangci/golangci-lint/cmd/golangci-lint
# compiler for embedded go
go_update github.com/tinygo-org/tinygo
# check git repo for secrets
go_update github.com/zricethezav/gitleaks
# lint dockerfiles; companion to hadolint
go_update github.com/zabio3/godolint
# format dockerfiles
go_update github.com/jessfraz/dockfmt
# generic language server
go_update github.com/mattn/efm-langserver

# protonmail bridge
go_update github.com/emersion/hydroxide/cmd/hydroxide
# my mail client
update_aerc() {
	aerc_dir="$GOPATH/src/git.sr.ht/~sircmpwn/aerc"
	mkdir -p "$aerc_dir"
	cd "$aerc_dir" || return 1
	export GO111MODULE=on
	git clone 'https://git.sr.ht/~sircmpwn/aerc' . || git reset --hard HEAD && git pull
	BINDIR="$GOPATH/bin" make
	BINDIR="$GOPATH/bin" make install
}

update_aerc

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
