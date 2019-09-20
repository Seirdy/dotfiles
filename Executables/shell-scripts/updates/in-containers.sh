#!/usr/bin/env dash
start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"

ghq_get_cd https://github.com/containers/fuse-overlayfs.git
cp Dockerfile.static Dockerfile
sed -i 's#registry\.fedoraproject\.org/fedora:latest#registry\.fedoraproject\.org/fedora:rawhide#' ./Dockerfile
sed -i 's/meson -/meson -D useroot=false -/' ./Dockerfile
# buildah bud -t fuse-overlayfs -f ./Dockerfile .
podman run -v "/tmp:/root/share" --rm --entrypoint="[]" fuse-overlayfs cp /usr/bin/fuse-overlayfs /usr/bin/fusermount3 /root/share
echo "made it here"
cp "/tmp/fuse-overlayfs" "$HOME/.local/bin" && chmod +x ~/.local/bin/fuse-overlayfs
cp "/tmp/fusermount3" "$HOME/.local/bin" && chmod +x ~/.local/bin/fuse-overlayfs

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"

# vi:ft=sh

