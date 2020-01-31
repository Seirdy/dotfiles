#!/usr/bin/env dash

# shellcheck disable=SC2086

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"
# shellcheck source=./cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"
export RUSTFLAGS="$RUSTFLAGS -C linker-plugin-lto -L. -C linker=clang -C link-arg=-fuse-ld=lld"
echo "Using RUSTFLAGS: $RUSTFLAGS"
echo "Using CARGO_INSTALL_OPTS: $CARGO_INSTALL_OPTS"

export CC=clang
export CXX=clang++
export CFLAGS="$CLANGFLAGS"
export CXXFLAGS="$CLANGFLAGS"

$CARGO_HOME/bin/rustup default nightly
$CARGO_HOME/bin/rustup update
cargo_update() {
	# shellcheck disable=SC2086
	$CARGO_HOME/bin/cargo --color always install-update "$@"
}
tmpdir="/tmp/$ARCH"
mkdir -p "$tmpdir"
# Update cargo-update before using it to update everything else
cargo_update cargo-update -t "$tmpdir"
cargo_update -figa -t "$tmpdir"

# newsboat
ghq_get_cd https://github.com/newsboat/newsboat.git \
	&& make clean \
	&& CFLAGS="$CLANGFLAGS_UNUSED_STUFF" CXXFLAGS="$CLANGFLAGS_UNUSED_STUFF" RUSTFLAGS="$RUSTFLAGS -C lto=fat" make \
	&& strip newsboat podboat \
	&& make install prefix="$PREFIX" \
	&& mv "$PREFIX/bin/newsboat" "$PREFIX/bin/podboat" "$CARGO_HOME/bin"

ghq_get_cd 'github.com/alacritty/alacritty' \
	&& cargo build --release --all-features -Z unstable-options \
	&& install -p -D -m644 extra/linux/alacritty.desktop "$DATAPREFIX/applications" \
	&& install -p -D -m644 extra/alacritty.man "$MANPREFIX/man1/alacritty.1" \
	&& tic -xe alacritty,alacritty-direct extra/alacritty.info -o "$DATAPREFIX/terminfo" \
	&& install -p -D -m644 extra/logo/alacritty-term.svg "$DATAPREFIX/pixmaps/Alacritty.svg" \
	&& strip ./target/*/alacritty \
	&& install -p -D -m755 target/release/alacritty "$CARGO_HOME/bin" \
	|| printf "try closing all alacritty terminals and running the following:\ncp %s/target/release/alacritty %s/.local/bin" "$PWD" "$HOME"

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
