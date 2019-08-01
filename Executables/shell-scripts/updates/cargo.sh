#!/usr/bin/env dash

start_time=$(date '+%s')

# Pretty colors!!
cargo_update() {
	cargo --color always install-update "$@"
}
# Update cargo-update before using it to update everything else
cargo_update cargo-update
cargo_update -ga

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
