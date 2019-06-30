#!/usr/bin/env dash

start_time=$(date '+%s')

# Update cargo-update before using it to update everything else
cargo install-update cargo-update
cargo install-update -ga
tldr --update

end_time=$(date '+%s')
elapsed=$(echo "${end_time} - ${start_time}" | bc)
echo "Time elapsed: ${elapsed} seconds"
