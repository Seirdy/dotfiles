#!/usr/bin/env dash

# This script builds fuse-overlayfs and fuseermount3 from source in a Fedora Rawhide
# unprivileged container.

start_time=$(date '+%s')

# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"
# shellcheck source=/home/rkumar/.config/shell_common/functions_ghq.sh
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"

# don't pull images twice
# cross-compilation for laptop happens at the same time as native builds for desktop
if [ "$CROSS_COMPILING" != 1 ]; then
	podman pull registry.fedoraproject.org/fedora:rawhide
	podman pull registry.fedoraproject.org/f33/fedora-toolbox
	podman pull alpine:edge
fi

# static, portable zsh
cd "$GHQ_ROOT/git.sr.ht/~seirdy/zsh-bin" \
	&& {
		oldfile="$(echo ./zsh-*-linux-x86_64.tar.gz)" \
			&& [ -e "$oldfile" ] && mv "$oldfile" "${oldfile%.*.*}.old.tar.gz"
	} || echo 'no previous builds' \
	&& dash ./build -d podman -g latest || echo 'done'
tar -xzf ./zsh-*-linux-x86_64.tar.gz \
	&& outdir="$(echo zsh-*-linux-x86_64)" \
	&& mkdir -p "$EXECUTABLES/zsh-bin/bin" \
	&& install -m 0755 "$outdir/bin/zsh" "$EXECUTABLES/zsh-bin/bin/zsh" \
	&& cp -r "$outdir/share" "$EXECUTABLES/zsh-bin/" \
	&& version="${outdir#*-}" && version="${version%-l*}" \
	&& dash "$EXECUTABLES/zsh-bin/share/zsh/$version/scripts/relocate" \
	&& rm -rf "$outdir"

# fusermount3 and fuse-overlayfs static binaries
ghq_get_cd https://github.com/containers/fuse-overlayfs.git
# Some patches:
# - speed up dnf with parallel downloads
# - don't clone a repo that already exists
# - use Fedora Rawhide
# - don't do unnecessary fuse installation in root; I just want
#   fusermount3 and fuse-overlayfs
sed \
	-e 's/dnf /dnf --setopt=max_parallel_downloads=20 --skip-broken /g' \
	-e 's#git clone https://github.com/containers/fuse-overlayfs #echo #' \
	-e 's/cd fuse-overlayfs/& \&\& git pull/' \
	-e 's#registry\.fedoraproject\.org/fedora:latest#registry.fedoraproject.org/fedora:rawhide#' \
	-e 's/meson -/meson -D useroot=false -/' \
	Dockerfile.static.fedora >Dockerfile.static.fedora.custom
BUILDAH_RUNTIME="$(command -v crun)"
export BUILDAH_RUNTIME
buildah bud -v "$PWD":/build/fuse-overlayfs -t fuse-overlayfs -f ./Dockerfile.static.fedora.custom . \
	&& mkdir -p bin && cd bin \
	&& podman run \
		-v "$PWD":/root/share:Z \
		--rm \
		--entrypoint="[]" \
		fuse-overlayfs cp /usr/bin/fuse-overlayfs /usr/bin/fusermount3 /root/share

install -m 0755 fuse-overlayfs "$BINPREFIX/fuse-overlayfs"
install -m 0755 fusermount3 "$BINPREFIX/fusermount3"

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"

# vi:ft=sh
