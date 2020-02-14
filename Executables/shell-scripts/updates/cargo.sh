#!/usr/bin/env dash

# shellcheck disable=SC2086

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"
# shellcheck source=./cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"
export RUSTFLAGS="$RUSTFLAGS -C linker-plugin-lto -L. -C linker=clang -C link-arg=-fuse-ld=lld"
echo "Using RUSTFLAGS: $RUSTFLAGS"
echo "Using CARGO_INSTALL_OPTS: $CARGO_INSTALL_OPTS"

export CC=clang
export CXX=clang++
export CFLAGS="$CLANGFLAGS"
export CXXFLAGS="$CLANGFLAGS"

cargo_update() {
	# shellcheck disable=SC2086
	$CARGO_HOME/bin/cargo --color always install-update "$@"
}

RUSTFLAGS_STATIC_LTO="$RUSTFLAGS -C target-feature=+crt-static -C lto=fat"

# a container with a MUSL environment for building static binaries with full LTO
musl_env() {
	podman run --rm -it \
		-v "$PWD:/root/src" \
		-v "$CARGO_HOME/registry:/root/.cargo/registry" \
		-e CFLAGS -e CXXFLAGS -e CPPFLAGS -e CC -e CXX -e LIBLDFLAGS -e MAKEFLAGS -e LDFLAGS \
		-e RUSTFLAGS="$RUSTFLAGS_STATIC_LTO" \
		rust-static-desktop "$@"
}

# basically cargo build --release for static binaries
cargo_static_lto() {
	musl_env cargo build --release --all-features -Z unstable-options --target=x86_64-unknown-linux-musl \
		&& strip "target/x86_64-unknown-linux-musl/release/$1" \
		&& install -p -D -m755 target/x86_64-unknown-linux-musl/release/$1 "$CARGO_HOME/bin"
}

# basically "cargo install" for static binaries
update_lto() {
	if [ ! -d "$GHQ_ROOT/$1" ] || {
		cd "$GHQ_ROOT/$1" && git fetch && git status | sed 2q | grep behind
	}; then
		{
			ghq_get_cd "$1" && cargo_static_lto "$2" || echo "failed to build $2"
		} || echo "$2 is up to date"
	fi
}

tmpdir="/tmp/$ARCH"
mkdir -p "$tmpdir"
# Update cargo-update before using it to update everything else
$CARGO_HOME/bin/rustup default nightly
$CARGO_HOME/bin/rustup update
cargo_update cargo-update -t "$tmpdir"
# update normal rust packages installed through "cargo install --git"
cargo_update -ga -t "$tmpdir"

# newsboat
ghq_get_cd https://github.com/newsboat/newsboat.git \
	&& make clean \
	&& CFLAGS="$CLANGFLAGS_UNUSED_STUFF" CXXFLAGS="$CLANGFLAGS_UNUSED_STUFF" RUSTFLAGS="$RUSTFLAGS_STATIC_LTO" make \
	&& strip newsboat podboat \
	&& make install prefix="$PREFIX" \
	&& mv "$PREFIX/bin/newsboat" "$PREFIX/bin/podboat" "$CARGO_HOME/bin"

cd "$GHQ_ROOT/github.com/alacritty/alacritty" \
	&& git fetch && git status | sed 2q | grep behind \
	&& {
		git reset --hard HEAD && git pull \
			&& cargo build --release --all-features -Z unstable-options \
			&& install -p -D -m644 extra/linux/alacritty.desktop "$DATAPREFIX/applications" \
			&& install -p -D -m644 extra/alacritty.man "$MANPREFIX/man1" \
			&& tic -xe alacritty,alacritty-direct extra/alacritty.info -o "$DATAPREFIX/terminfo" \
			&& install -p -D -m644 extra/logo/alacritty-term.svg "$DATAPREFIX/pixmaps/Alacritty.svg" \
			&& install -p -D -m755 target/release/alacritty "$CARGO_HOME/bin" \
			|| printf "try closing all alacritty terminals and running the following:\ncp %s/target/release/alacritty %s/.local/bin" "$PWD" "$HOME"
	} || echo "alacritty is up to date"

# static binaries built inside a container
update_lto github.com/Peltoche/lsd lsd
update_lto github.com/sharkdp/fd fd
update_lto github.com/sharkdp/diskus diskus
update_lto github.com/NerdyPepper/eva eva
update_lto github.com/jameslzhu/roflcat roflcat

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
