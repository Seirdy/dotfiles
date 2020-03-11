#!/usr/bin/env dash
start_time=$(date '+%s')

# shellcheck source=/home/rkumar/.config/shell_common/functions_ghq.sh disable=SC2154
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

export CC=clang
export CXX=clang++
export CFLAGS="$CLANGFLAGS"
export LDFLAGS="$CFLAGS" CXXFLAGS="$CFLAGS" CPPFLAGS="$CFLAGS"

cargo_update() {
	# shellcheck disable=SC2086
	$CARGO_HOME/bin/cargo --color always install-update "$@"
}

# Flags for building static binaries/libs with fat LTO optimization
# Fat LTO optimization is slow, but it (theoretically) produces a
# better result than thinLTO. Maybe just a placebo.
export RUSTFLAGS_STATIC_LTO="$RUSTFLAGS \
	-L. \
	-C linker-plugin-lto \
	-C linker=clang \
	-C link-arg=-fuse-ld=lld \
	-C target-feature=+crt-static \
	-C lto=fat"

tmpdir="/tmp/$ARCH"
mkdir -p "$tmpdir"
# Update cargo-update before using it to update everything else
"$CARGO_HOME/bin/rustup" default nightly
"$CARGO_HOME/bin/rustup" update
cargo_update cargo-update -t "$tmpdir"
# update normal rust packages installed through "cargo install --git"
cargo_update -ga -t "$tmpdir"

# newsboat
cd "$GHQ_ROOT/github.com/newsboat/newsboat" \
	&& git fetch && git status | sed 2q | grep behind \
	&& {
		git reset --hard HEAD && git pull && make clean \
			&& CFLAGS="$CLANGFLAGS_UNUSED_STUFF" CXXFLAGS="$CLANGFLAGS_UNUSED_STUFF" LDFLAGS="$CLANGFLAGS_UNUSED_STUFF" RUSTFLAGS="$RUSTFLAGS_STATIC_LTO" make \
			&& make install prefix="$PREFIX" \
			&& mv "$PREFIX/bin/newsboat" "$PREFIX/bin/podboat" "$CARGO_HOME/bin"
	} || echo "newsboat is up to date"

cd "$GHQ_ROOT/github.com/alacritty/alacritty" \
	&& git fetch && git status | sed 2q | grep behind \
	&& {
		git reset --hard HEAD && git pull \
			&& cargo +nightly build --release --all-features -Z unstable-options \
			&& install -p -D -m644 extra/linux/alacritty.desktop "$DATAPREFIX/applications" \
			&& install -p -D -m644 extra/alacritty.man "$MANPREFIX/man1" \
			&& tic -xe alacritty,alacritty-direct extra/alacritty.info -o "$DATAPREFIX/terminfo" \
			&& install -p -D -m644 extra/logo/alacritty-term.svg "$DATAPREFIX/pixmaps/Alacritty.svg" \
			&& install -p -D -m755 target/release/alacritty "$CARGO_HOME/bin" \
			|| printf "try closing all alacritty terminals and running the following:\ncp %s/target/release/alacritty %s/.local/bin" "$PWD" "$HOME"
	} || echo "alacritty is up to date"

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
