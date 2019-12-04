#!/usr/bin/env dash
# This contains programs that used to be in go.sh, but were really slow to update.
# They deserve their own file to run in parallel.

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

go_update_cni() {
	echo '##'
	echo "## Installing CNI plugin $*"
	echo '##'
	echo "go get -u -v github.com/containernetworking/plugins/plugins/$1"
	plgname=$(basename "$1")
	go build -o "$HOME/.local/libexec/cni/$plgname" -mod=vendor "$GOPATH/src/$1"

}
# Access cloud storage
go_update github.com/rclone/rclone
# Run my CI/CD pipelines locally
go_update gitlab.com/gitlab-org/gitlab-runner
if [ "$MACHINE" = 'Linux' ]; then
	# install the OCI stack along with its manpages
	# This includes:
	# - runc
	# - podman
	# - buildah
	# - skopeo
	# - all relevant CNI plugins
	# components written in C (like fuse-overlayfs and conmon) are built elsewhere
	runc_import_path="github.com/opencontainers/runc"
	go_update "$runc_import_path" \
		&& cd "$GOPATH/src/$runc_import_path" \
		&& BUILDTAGS='seccomp' make && cp ./runc "$GOPATH/bin/runc" \
		&& cd - || exit 1
	go_update github.com/containers/skopeo/cmd/skopeo \
		&& cd "$GOPATH/src/github.com/containers/skopeo" \
		&& make docs \
		&& install -d "$HOME/.local/share/man/man1" \
		&& install -m 0644 docs/*.1 "$HOME/.local/share/man/man1"
	# export GO111MODULE=on
	# podman
	printf '###\n### Updating podman ###\n###\n'
	# Do not install podman binary when working with the Makefile
	[ -d "$GOPATH/src/github.com/containers/libpod" ] || git clone https://github.com/containers/libpod/ "$GOPATH/src/github.com/containers/libpod" \
		&& cd "$GOPATH/src/github.com/containers/libpod" \
		&& git pull \
		&& make BUILDTAGS="seccomp" \
		&& make PREFIX="$HOME/.local" BINDIR="$GOPATH/bin" ETCDIR="$XDG_CONFIG_HOME" install
	go_update github.com/containers/buildah/cmd/buildah \
		&& cd "$GOPATH/src/github.com/containers/buildah/docs" \
		&& GOMD2MAN="$GOPATH/bin/go-md2man" make \
		&& install -d "$HOME/.local/share/man/man1" \
		&& install -m 0644 buildah*.1 "$HOME/.local/share/man/man1"
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

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
