#!/usr/bin/env dash

start_time=$(date '+%s')

go_update() {
	echo "###"
	echo "### Updating $* ###"
	echo "###"
	cd "$GOPATH/src/$1" && git reset --hard HEAD && cd - || echo "$1 doesn't seem to be installed yet."
	go get -u -v "$*" 2>&1 # verbose output is sent to stderr for some reason
}
# update go itself
go_update golang.org/dl/gotip
HOME=$GOPATH gotip download

# building docs for some golang packages
go_update github.com/cpuguy83/go-md2man
# Critical programs for my workflow; computer is useless without them
go_update github.com/Code-Hex/Neo-cowsay/cmd/cowsay
go_update github.com/Code-Hex/Neo-cowsay/cmd/cowthink
# If htop wasn't pretty enough
go_update github.com/cjbassi/gotop
# fzf
go_update github.com/junegunn/fzf
# Test dl speed
go_update github.com/ddo/fast
# Quickly share files between computers
go_update github.com/schollz/croc
# Pager for log files
go_update github.com/tigrawap/slit/cmd/slit
# shell script formatter
go_update github.com/mvdan/sh/cmd/shfmt
# like jq but for yaml
go_update github.com/mikefarah/yq
# curlie: better than httpie
go_update github.com/rs/curlie
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
go_update github.com/motemen/ghq
# extra commands for ghq
go_update github.com/uetchy/gst
# matrix client, for when I get bored of weechat-matrix
go_update github.com/tulir/gomuks
# MPRIS bridge for MPD
go_update github.com/natsukagami/mpd-mpris/cmd/mpd-mpris

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

# my mail client
update_aerc() {
	aerc_dir="$GOPATH/src/git.sr.ht/~sircmpwn/aerc"
	mkdir -p "$aerc_dir"
	cd "$aerc_dir" || return 1
	export GO111MODULE=on
	git clone 'https://git.sr.ht/~sircmpwn/aerc' . || git reset --hard HEAD && git pull
	PREFIX=$HOME/.local BINDIR="$GOPATH/bin" make
	PREFIX=$HOME/.local BINDIR="$GOPATH/bin" make install
}

update_aerc

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
