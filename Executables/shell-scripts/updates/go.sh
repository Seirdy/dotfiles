#!/usr/bin/env dash

start_time=$(date '+%s')

go_update() {
	echo "###"
	echo "### Updating $* ###"
	echo "###"
	go get -u -v "$*" 2>&1 # verbose output is sent to stderr for some reason
}
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
# Access cloud storage
go_update github.com/rclone/rclone
# Pager for log files
go_update github.com/tigrawap/slit/cmd/slit
# shell script formatter
go_update github.com/mvdan/sh/cmd/shfmt
# like jq but for yaml
go_update github.com/mikefarah/yq
# matrix client, for when I get bored of weechat-matrix
go_update github.com/tulir/gomuks
# Alternative to urlview
go_update github.com/imwally/linkview
# Learn go
go_update golang.org/x/tour
# godoc webserver
go_update golang.org/x/tools/cmd/godoc
# Alternative terminal emulator
# github.com/liamg/aminal
# Advanced file manager (like ranger)
go_update github.com/gokcehan/lf

# podman > docker
if [ "$MACHINE" = 'Linux' ]; then
	go_update github.com/containers/libpod/cmd/podman
else
	# podman-machine is like docker-machine/docker desktop
	go_update https://github.com/boot2podman/machine/cmd/podman-machine
fi
# Development tools
#

# language server
go_update golang.org/x/tools/gopls
# linting
go_update github.com/golangci/golangci-lint/cmd/golangci-lint
# More strict than gofmt
go_update mvdan.cc/gofumpt
go_update mvdan.cc/gofumpt/gofumports
# Dependency graph
go_update github.com/kisielk/godepgraph
# best sloc cloc and code counter
go_update github.com/boyter/scc
# Run my CI/CD pipelines locally
go_update gitlab.com/gitlab-org/gitlab-runner

# my mail client
update_aerc() {
	aerc_dir="$GOPATH/src/git.sr.ht/~sircmpwn/aerc"
	if [ ! -d "$aerc_dir" ]; then
		mkdir -p "$aerc_dir"
	fi
	cd "$aerc_dir" || return 1
	export GO111MODULE=on
	go_update 'git.sr.ht/~sircmpwn/aerc'
	PREFIX=$HOME/.local BINDIR="$GOPATH/bin" make
	PREFIX=$HOME/.local BINDIR="$GOPATH/bin" make install
}

update_aerc

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
