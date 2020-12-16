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

tmpdir="/tmp/$ARCH"
cargo_update() {
	# shellcheck disable=SC2086
	"$CARGO_HOME/bin/cargo" +nightly --color always install-update "$@" -t "$tmpdir"
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
	-C lto=fat
	-C embed-bitcode=yes"

mkdir -p "$tmpdir"
# Update cargo-update before using it to update everything else
"$CARGO_HOME/bin/rustup" default nightly
"$CARGO_HOME/bin/rustup" update
cargo_update cargo-update
CARGO_INSTALL_OPTS="--features pulseaudio $CARGO_INSTALL_OPTS" cargo_update -g i3status-rs

cargo_update_static() {
	CARGO_INSTALL_OPTS="--target x86_64-unknown-linux-musl $CARGO_INSTALL_OPTS" RUSTFLAGS="$RUSTFLAGS_STATIC_LTO" cargo install-update -g "$@"
}
cargo_update_static agate
cargo_update_static svgcleaner
CARGO_INSTALL_OPTS="--features=vendored-openssl $CARGO_INSTALL_OPTS" cargo_update_static lychee
cargo_update -ga

# newsboat
ghq_get_cd https://github.com/newsboat/newsboat.git
cd "$GHQ_ROOT/github.com/newsboat/newsboat" \
	&& git reset --hard origin/HEAD && git pull && make clean \
	&& make \
	&& make install prefix="$PREFIX" \
	&& mv "$PREFIX/bin/newsboat" "$PREFIX/bin/podboat" "$CARGO_HOME/bin"

# we've already updated the alacritty binary; this is everything else
ghq_get_cd github.com/alacritty/alacritty.git \
	&& install -p -D -m644 extra/linux/Alacritty.desktop "$DATAPREFIX/applications" \
	&& install -p -D -m644 extra/alacritty.man "$MANPREFIX/man1" \
	&& tic -xe alacritty,alacritty-direct extra/alacritty.info -o "$DATAPREFIX/terminfo" \
	&& install -p -D -m644 extra/logo/alacritty-term.svg "$DATAPREFIX/pixmaps/Alacritty.svg" \
	|| printf "try closing all alacritty terminals and running the following:\ncp %s/target/release/alacritty %s/.local/bin\n" "$PWD" "$HOME"

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
