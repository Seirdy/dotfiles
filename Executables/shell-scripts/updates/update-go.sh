#!/usr/bin/env dash

go_update() {
	go get -u -v "$@" 2>&1  # verbose output is sent to stderr for some reason
}

go_update github.com/cjbassi/gotop
go_update github.com/mattn/efm-langserver/cmd/efm-langserver
go_update github.com/Code-Hex/Neo-cowsay/cmd/cowsay
go_update github.com/Code-Hex/Neo-cowsay/cmd/cowthink
go_update github.com/ddo/fast
go_update golang.org/x/tour
go_update git.sr.ht/~sircmpwn/aerc
