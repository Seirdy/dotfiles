#!/usr/bin/env dash

# shellcheck disable=SC2086

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"
# shellcheck source=./cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"
echo "Using RUSTFLAGS: $RUSTFLAGS"
echo "Using CARGO_INSTALL_OPTS: $CARGO_INSTALL_OPTS"

$CARGO_HOME/bin/rustup default nightly
$CARGO_HOME/bin/rustup update
cargo_update() {
	# shellcheck disable=SC2086
	$CARGO_HOME/bin/cargo --color always install-update "$@"
}
# Update cargo-update before using it to update everything else
cargo_update cargo-update
cargo_update -ga

ghq_get_cd 'github.com/jwilm/alacritty' \
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
