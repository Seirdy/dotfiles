#!/usr/bin/env dash

start_time=$(date '+%s')

go_update() {
	go get -u -v "$@" 2>&1 # verbose output is sent to stderr for some reason
}

# My mail client
go_update git.sr.ht/~sircmpwn/aerc
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
# matrix client, for when I get bored of weechat-matrix
go_update github.com/tulir/gomuks
# More strict than gofmt
go_update mvdan.cc/gofumpt
# Run my CI/CD pipelines locally
go_update gitlab.com/gitlab-org/gitlab-runner
# Learn go
go_update golang.org/x/tour

# better version of go language server
bingo_dir="$GOPATH/src/github.com/sailbing"
if [ -d "$bingo_dir/tools" ]; then
	cd "$bingo_dir/tools" || exit
	git pull
else
	mkdir -p "$bingo_dir"
	cd "$bingo_dir" || exit
	git clone --recursive -b bingo https://github.com/saibing/tools.git
	cd tools || exit
fi
cd gopls || exit
go install

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
