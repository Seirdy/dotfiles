#!/usr/bin/env dash

start_time=$(date '+%s')

# Pretty colors!!
cargo_update() {
	cargo --color always install-update "$@"
}
# Update cargo-update before using it to update everything else
cargo_update cargo-update
cargo_update -ga

cd "$GHQ_ROOT/github.com/jwilm/alacritty" \
	&& git pull && git submodule update --init --recursive --force --remote \
	&& cargo build --release \
	&& cp ./target/release/alacritty "$HOME/.local/bin" \
	|| printf "try closing all alacritty terminals and running the following:\ncp %s/target/release/alacritty %s/.local/bin" "$PWD" "$HOME"

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
