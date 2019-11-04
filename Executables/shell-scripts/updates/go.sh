#!/usr/bin/env dash

start_time=$(date '+%s')

go_update() {
	echo "###"
	echo "### Updating $* ###"
	echo "###"
	for url in "$@"; do
		cd "$GOPATH/src/$url" && git reset --hard HEAD && cd - || echo "$url doesn't seem to be installed yet."
	done
	go get -u -v "$@" 2>&1 # verbose output is sent to stderr for some reason
}
# update go itself
go_update golang.org/dl/gotip
HOME=$GOPATH gotip download

go_update \
	github.com/cpuguy83/go-md2man \
	github.com/Code-Hex/Neo-cowsay/cmd/cowsay \
	github.com/Code-Hex/Neo-cowsay/cmd/cowthink \
	github.com/junegunn/fzf \
	github.com/ddo/fast \
	github.com/mvdan/sh/cmd/shfmt \
	github.com/jessfraz/dockfmt \
	github.com/tigrawap/slit/cmd/slit \
	github.com/imwally/linkview \
	github.com/natsukagami/mpd-mpris/cmd/mpd-mpris \
	github.com/cjbassi/gotop \
	github.com/ddo/fast \
	github.com/mikefarah/yq \
	github.com/rs/curlie \
	github.com/r00tman/corrupter \
	github.com/gokcehan/lf \
	github.com/github/hub \
	github.com/motemen/ghq \
	github.com/tulir/gomuks \
	mvdan.cc/gofumpt mvdan.cc/gofumpt/gofumports \
	github.com/kisielk/godepgraph \
	github.com/boyter/scc \
	golang.org/x/tools/gopls golang.org/x/tour golang.org/x/tools/cmd/godoc \
	github.com/golangci/golangci-lint/cmd/golangci-lint \
	github.com/tinygo-org/tinygo \
	github.com/zricethezav/gitleaks \
	github.com/zabio3/godolint

go_update github.com/zaquestion/lab || echo "failed to install lab"
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
