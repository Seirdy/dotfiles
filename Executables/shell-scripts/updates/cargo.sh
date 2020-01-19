#!/usr/bin/env dash

start_time=$(date '+%s')

# Pretty colors!!
cargo_update() {
	cargo --color always install-update "$@"
}
# Update cargo-update before using it to update everything else
cargo_update cargo-update
cargo_update -ga

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"

ghq_get_cd 'github.com/jwilm/alacritty' \
	&& cargo build --release --all-features -Z unstable-options \
	&& install -p -D -m644 extra/linux/alacritty.desktop "$XDG_DATA_HOME/applications" \
	&& install -p -D -m644 extra/alacritty.man "$HOME/.local/man/man1/alacritty.1" \
	&& tic -xe alacritty,alacritty-direct extra/alacritty.info -o "$XDG_DATA_HOME/terminfo" \
	&& install -p -D -m644 extra/logo/alacritty-term.svg "$XDG_DATA_HOME/pixmaps/Alacritty.svg" \
	&& strip ./target/release/alacritty \
	&& install -p -D -m755 target/release/alacritty "$HOME/.local/bin" \
	|| printf "try closing all alacritty terminals and running the following:\ncp %s/target/release/alacritty %s/.local/bin" "$PWD" "$HOME"

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
