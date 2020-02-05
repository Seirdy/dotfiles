#!/usr/bin/env dash

# This script builds fuse-overlayfs and fuseermount3 from source in a Fedora Rawhide
# unprivileged container.

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"

ghq_get_cd https://github.com/containers/fuse-overlayfs.git
cp Dockerfile.static.fedora Dockerfile.static.fedora.custom
# speed up downloading
sed -i 's/dnf /dnf --setopt=max_parallel_downloads=20 /g' ./Dockerfile.static.fedora.custom
sed -i 's#registry\.fedoraproject\.org/fedora:latest#registry.fedoraproject.org/fedora:rawhide#' ./Dockerfile.static.fedora.custom
sed -i 's/meson -/meson -D useroot=false -/' ./Dockerfile.static.fedora.custom

export BUILDAH_RUNTIME="$HOME/.local/bin/crun"
buildah bud -t fuse-overlayfs -f ./Dockerfile.static.fedora.custom .
podman run -v "/tmp:/root/share" --rm --entrypoint="[]" fuse-overlayfs cp /usr/bin/fuse-overlayfs /usr/bin/fusermount3 /root/share

install -m 0755 "/tmp/fuse-overlayfs" "$HOME/.local/bin/fuse-overlayfs"
install -m 0755 "/tmp/fusermount3" "$HOME/.local/bin/fusermount3"

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"

# vi:ft=sh

