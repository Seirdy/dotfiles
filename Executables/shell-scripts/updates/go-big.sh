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
# Access cloud storage
go_update github.com/rclone/rclone
# Run my CI/CD pipelines locally
go_update gitlab.com/gitlab-org/gitlab-runner
# # podman > docker
if [ "$MACHINE" = 'Linux' ]; then
	# install the OCI stack along with its manpages
	# This includes runc, podman, buildah, skopeo, and container networking plugins
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
	go_update k8s.io/client-go@master
	go_update k8s.io/client-go/rest@master
	go_update github.com/containers/libpod/cmd/podman@master
	go_update github.com/containernetworking/plugins/plugins/ipam/dhcp \
		&& cd "$GOPATH/src/github.com/containernetworking/plugins/plugins" \
		&& {
			plugins="meta/* main/* ipam/*"
			for plg in $plugins; do
				plgname="$(basename "$plg")"
				if [ -d "$plg" ] && [ "$plgname" != "windows" ]; then
					echo "## Installing CNI plugin $plgname"
					go_update "github.com/containernetworking/plugins/plugins/$plg"
				fi
			done
		}
	go_update github.com/containers/buildah/cmd/buildah \
		&& cd "$GOPATH/src/github.com/containers/buildah/docs" \
		&& make \
		&& install -d "$HOME/.local/share/man/man1" \
		&& install -m 0644 buildah*.1 "$HOME/.local/share/man/man1"
else
	# podman-machine is like docker-machine/docker desktop
	go_update https://github.com/boot2podman/machine/cmd/podman-machine
fi

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
