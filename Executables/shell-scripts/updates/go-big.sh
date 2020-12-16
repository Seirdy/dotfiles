#!/usr/bin/env dash
# This contains programs that used to be in go.sh, but were really slow to update.
# They deserve their own file to run in parallel.

start_time=$(date '+%s')

# shellcheck source=/home/rkumar/.config/shell_common/functions_ghq.sh disable=SC2154
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"
if "$GOPATH/sdk/gotip/bin/go" version >/dev/null; then
	export GOROOT="$GOPATH/sdk/gotip"
	export GOTOOLDIR="$GOROOT/pkg/tool/linux_amd64"
fi
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

go_update_cni() {
	echo '##'
	echo "## Installing CNI plugin $*"
	echo '##'
	echo "go get -u -v github.com/containernetworking/plugins/plugins/$1"
	plgname=$(basename "$1")
	go build -o "$PREFIX/libexec/cni/$plgname" -mod=vendor "$GOPATH/src/$1"

}
# Access cloud storage
go_update github.com/rclone/rclone
install -Dpm 0644 "$GOPATH/src/github.com/rclone/rclone/rclone.1" "$MANPREFIX/man1"
# Run my CI/CD pipelines locally
go_update gitlab.com/gitlab-org/gitlab-runner
if [ "$MACHINE" = 'Linux' ]; then
	# install the OCI stack along with its manpages
	# This includes:
	# - podman
	# - buildah
	# - skopeo
	# - all relevant CNI plugins
	# components written in C (like fuse-overlayfs and conmon) are built elsewhere
	go_update github.com/containers/skopeo/cmd/skopeo \
		&& cd "$GOPATH/src/github.com/containers/skopeo" \
		&& make docs \
		&& install -d "$MANPREFIX/man1" \
		&& install -m 0644 docs/*.1 "$MANPREFIX/man1"
	# export GO111MODULE=on
	# podman
	printf '###\n### Updating podman ###\n###\n'
	# Do not install podman binary when working with the Makefile
	[ -d "$GOPATH/src/github.com/containers/libpod" ] || git clone https://github.com/containers/libpod/ "$GOPATH/src/github.com/containers/libpod" \
		&& cd "$GOPATH/src/github.com/containers/libpod" \
		&& git stash \
		&& git pull \
		&& make BUILDTAGS="seccomp" \
		&& make BINDIR="$GOPATH/bin" ETCDIR="$CONFIGPREFIX" MANDIR="$MANPREFIX" install
	# buildah
	GOFLAGS="$GOFLAGS -mod=vendor" go_update github.com/containers/buildah/cmd/buildah \
		&& cd "$GOPATH/src/github.com/containers/buildah/docs" \
		&& GOMD2MAN="$GOPATH/bin/go-md2man" make \
		&& install -d "$MANPREFIX/man1" \
		&& install -m 0644 buildah*.1 "$MANPREFIX/man1"
	# all the relevant CNI plugins
	if [ -d "$GOPATH/src/github.com/containernetworking/plugins" ]; then
		mkdir -p "$GOPATH/src/github.com/containernetworking/plugins" \
			&& git clone 'https://github.com/containernetworking/plugins.git' "$GOPATH/src/github.com/containernetworking/plugins"
	fi
	go clean -modcache
	cd "$GOPATH/src/github.com/containernetworking/plugins/plugins" \
		&& git pull \
		&& {
			plugins="meta/* main/* ipam/*"
			for plg in $plugins; do
				plgname="$(basename "$plg")"
				if [ -d "$plg" ] && [ "$plgname" != "windows" ]; then
					go_update_cni "github.com/containernetworking/plugins/plugins/$plg"
				fi
			done
		}
else
	# podman-machine is like docker-machine/docker desktop
	go_update https://github.com/boot2podman/machine/cmd/podman-machine
fi

# linting
go_update github.com/golangci/golangci-lint/cmd/golangci-lint

ghq_get_cd https://github.com/gohugoio/hugo.git \
	&& GO111MODULE=on \
		CGO_ENABLED=0 \
		GOFLAGS="$GOFLAGS -buildmode=pie -tags=osuergo,netgo,static_build" go install -v -ldflags='-extldflags=-static -w -s' \
		&& hugo gen man \
		&& install -Dp man/* -t "$MANDIR/man1"

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
