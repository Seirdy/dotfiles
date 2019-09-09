#!/usr/bin/env dash
# This contains programs that used to be in go.sh, but were really slow to update.
# They deserve their own file to run in parallel.

start_time=$(date '+%s')

go_update() {
	echo "###"
	echo "### Updating $* ###"
	echo "###"
	go get -u -v "$*" 2>&1 # verbose output is sent to stderr for some reason
}

echo "## Updating Golang to latest development version"
go_update golang.org/dl/gotip
HOME=$GOPATH gotip download 2>&1
# Access cloud storage
go_update github.com/rclone/rclone
# Run my CI/CD pipelines locally
go_update gitlab.com/gitlab-org/gitlab-runner
# language server
go_update golang.org/x/tools/gopls
# linting
go_update github.com/golangci/golangci-lint/cmd/golangci-lint
# Learn go
go_update golang.org/x/tour
# godoc webserver
go_update golang.org/x/tools/cmd/godoc
# podman > docker
if [ "$MACHINE" = 'Linux' ]; then
	go_update github.com/containers/libpod/cmd/podman
else
	# podman-machine is like docker-machine/docker desktop
	go_update https://github.com/boot2podman/machine/cmd/podman-machine
fi
# matrix client, for when I get bored of weechat-matrix
go_update github.com/tulir/gomuks

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
