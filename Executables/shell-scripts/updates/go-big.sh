#!/usr/bin/env dash
# This contains programs that used to be in go.sh, but were really slow to update.
# They deserve their own file to run in parallel.

start_time=$(date '+%s')

echo 'cleaning modcache'
go clean -modcache
echo 'cleaned modcache'

go_update() {
	echo "###"
	echo "### Updating $* ###"
	echo "###"
	go get -u -v "$*" 2>&1 # verbose output is sent to stderr for some reason
}

go_update_cni() {
	echo '##'
	echo "## Installing CNI plugin $*"
	echo '##'
	echo "go get -u -v github.com/containernetworking/plugins/plugins/$1"
	GOBIN="$HOME/.local/libexec/cni" go get -u -v "github.com/containernetworking/plugins/plugins/$1"

}
# Access cloud storage
go_update github.com/rclone/rclone
# Run my CI/CD pipelines locally
go_update gitlab.com/gitlab-org/gitlab-runner
if [ "$MACHINE" = 'Linux' ]; then
	# install the OCI stack along with its manpages
	# This includes:
	#		- runc
	#		- podman
	#		- buildah
	#		- skopeo
	#		- all relevant CNI plugins
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
	export GO111MODULE=on
	# podman
	printf '###\n### Updating podman ###\n###\n'
	[ -d "$GOPATH/src/github.com/containers/libpod" ] || git clone https://github.com/containers/libpod/ "$GOPATH/src/github.com/containers/libpod" \
		&& cd "$GOPATH/src/github.com/containers/libpod" \
		&& git pull \
		&& make BUILDTAGS="seccomp" \
		&& make PREFIX="$HOME/.local" BINDIR="$GOPATH/bin" ETCDIR="$XDG_CONFIG_HOME" install
	# update podman again, this time without all the flags from its makefile
	# Rerun on failure
	echo 'Building podman without flags'
	go get -u -v github.com/containers/libpod/cmd/podman || go get -u -v github.com/containers/libpod/cmd/podman
	# all the relevant CNI plugins
	if [ -d "$GOPATH/src/github.com/containernetworking/plugins" ]; then
		mkdir -p "$GOPATH/src/github.com/containernetworking/plugins" \
			&& git clone 'https://github.com/containernetworking/plugins.git' "$GOPATH/src/github.com/containernetworking/plugins"
	fi
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
	go_update github.com/containers/buildah/cmd/buildah \
		&& cd "$GOPATH/src/github.com/containers/buildah/docs" \
		&& GOMD2MAN="$GOPATH/bin/go-md2man" make \
		&& install -d "$HOME/.local/share/man/man1" \
		&& install -m 0644 buildah*.1 "$HOME/.local/share/man/man1"
else
	# podman-machine is like docker-machine/docker desktop
	go_update https://github.com/boot2podman/machine/cmd/podman-machine
fi

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
