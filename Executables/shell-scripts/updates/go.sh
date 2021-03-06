#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
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
	cd "$GOPATH/src/$1" && git reset --hard HEAD && git clean -fx && cd - || echo "$1 doesn't seem to be installed yet."
	go get -u -v "$*" 2>&1 # verbose output is sent to stderr for some reason
}
go_update_static() {
	# shellcheck disable=SC2034 # CGO_ENABLED is in fact used by cmd/go.
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 GOFLAGS="$GOFLAGS -buildmode=pie -tags=osusergo,netgo,static_build" go_update "$*"
}

go_install_static() {
	# shellcheck disable=SC2034 # CGO_ENABLED is in fact used by cmd/go.
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 GOFLAGS="$GOFLAGS -buildmode=pie -tags=osusergo,netgo,static_build" go install "$*"
}

# building docs for some golang packages
go_update github.com/cpuguy83/go-md2man
# Critical programs for my workflow; computer is useless without them
go_update github.com/Code-Hex/Neo-cowsay/cmd/cowsay
go_update github.com/Code-Hex/Neo-cowsay/cmd/cowthink
# If htop wasn't pretty enough
ghq_get_cd https://github.com/xxxserxxx/gotop.git \
	&& go_install_static ./cmd/gotop
# encode avif
go_update github.com/Kagami/go-avif
# fzf
ghq_get_cd github.com/junegunn/fzf \
	&& go_install_static . \
	&& install -p -m644 "$PWD"/man/man1/* "$MANPREFIX/man1"
# Test dl speed
go_update github.com/ddo/fast                                            # fast.com
go_install_static github.com/m-lab/ndt7-client-go/cmd/ndt7-client@master # measurement lab
# alternate pager
go_update github.com/walles/moar
# Quickly share files between computers
GO111MODULE=on go_update_static github.com/schollz/croc/v8
# like croc but with qr codes
go_update github.com/claudiodangelis/qrcp
# Pager for log files
GO111MODULE=on go_update_static github.com/tigrawap/slit/cmd/slit
# shell script formatter
GO111MODULE=on go_update_static mvdan.cc/sh/v3/cmd/shfmt
# like jq but for yaml
GO111MODULE=on go_install_static github.com/mikefarah/yq/v4@master
# curlie: better than httpie
go_update github.com/rs/curlie
# profile (neo)vim startuptime
go_update github.com/rhysd/vim-startuptime
# url pickers
GO111MODULE=on go_update_static mvdan.cc/xurls/v2/cmd/xurls
go_update github.com/imwally/linkview
# "reader mode"
go_update_static github.com/go-shiori/go-readability/cmd/...
# corrupts images for fancy lockscreen
go_update github.com/r00tman/corrupter
# Alternative terminal emulator
# github.com/liamg/aminal
# Advanced file manager (like ranger)
go_update_static github.com/gokcehan/lf
# github and gitlab CLI
go_update github.com/github/hub \
	&& cd "$GOPATH/src/github.com/github/hub" \
	&& git clean -x \
	&& git reset --hard origin/HEAD \
	&& make man-pages \
	&& install -p -m644 "$GOPATH"/src/github.com/github/hub/share/man/man1/* "$MANPREFIX/man1"
go_update github.com/zaquestion/lab || echo "failed to install lab"
# used to clone repos into a nice directory tree like "go get" does
GO111MODULE=on go_update github.com/x-motemen/ghq
# extra commands for ghq
go_update github.com/uetchy/gst
# matrix client, for when I get bored of weechat-matrix
ghq_get_cd https://github.com/tulir/gomuks.git && go install
# MPRIS bridge for MPD
go_update github.com/natsukagami/mpd-mpris/cmd/mpd-mpris
# dictionary CLI
go_update github.com/Rican7/define
# gemini/gopher/etc
ghq get -u -b develop https://tildegit.org/sloum/bombadillo.git \
	&& cd "$GHQ_ROOT/tildegit.org/sloum/bombadillo" \
	&& GO111MODULE=on go install -v \
	&& install -p -m0644 "bombadillo.1" "$MANPREFIX/man1" \
	&& install -p -m0644 "bombadillo.desktop" "$DATAPREFIX/applications"

ghq_get_cd https://github.com/makeworld-the-better-one/amfora.git && GO111MODULE=on go install -v && install -Dm 0644 amfora.desktop "$DATAPREFIX/applications/"

ghq_get_cd 'https://git.sr.ht/~adnano/astronaut' && BINDIR="$GOPATH/bin" make install

ghq_get_cd https://github.com/RasmusLindroth/tut.git && go install

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
# compiler for embedded go
go_update github.com/tinygo-org/tinygo
# check git repo for secrets
go_update github.com/zricethezav/gitleaks
# lint dockerfiles; companion to hadolint
ghq_get_cd github.com/zabio3/godolint && go install
# format dockerfiles
go_update github.com/jessfraz/dockfmt
# lint makefiles
ghq_get_cd https://github.com/mrtazz/checkmake.git \
	&& go_install_static . \
	&& make checkmake.1
# generic language server
GO111MODULE=on go_update github.com/mattn/efm-langserver

# protonmail bridge
go_update github.com/emersion/hydroxide/cmd/hydroxide
# my mail client
update_aerc() {
	aerc_dir="$GOPATH/src/git.sr.ht/~sircmpwn/aerc"
	mkdir -p "$aerc_dir"
	cd "$aerc_dir" || return 1
	export GO111MODULE=on
	git clone 'https://git.sr.ht/~sircmpwn/aerc' . || git reset --hard HEAD && git pull
	BINDIR="$GOPATH/bin" GOFLAGS="$GOFLAGS -tags=notmuch" make
	BINDIR="$GOPATH/bin" make install
}

update_aerc

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
