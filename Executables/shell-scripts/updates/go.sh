#!/usr/bin/env dash

STARTTIME=$(date '+%s')

go_update() {
	go get -u -v "$@" 2>&1  # verbose output is sent to stderr for some reason
}

# My mail client
go_update git.sr.ht/~sircmpwn/aerc
# Critical programs for my workflow; computer is useless without them
go_update github.com/Code-Hex/Neo-cowsay/cmd/cowsay
go_update github.com/Code-Hex/Neo-cowsay/cmd/cowthink
# If htop wasn't pretty enough
go_update github.com/cjbassi/gotop
# Test dl speed
go_update github.com/ddo/fast
# Create a langserver from linters and formatters
go_update github.com/mattn/efm-langserver/cmd/efm-langserver
# Quickly share files between computers
go_update github.com/schollz/croc
# Pager for log files
go_update github.com/tigrawap/slit/cmd/slit
# Run my CI/CD pipelines locally
go_update gitlab.com/gitlab-org/gitlab-runner
# Learn go
go_update golang.org/x/tour

ENDTIME=$(date '+%s')
ELAPSED=$(echo "${ENDTIME} - ${STARTTIME}" | bc)
echo "Time elapsed: ${ELAPSED} seconds"
