#!/usr/bin/env dash

STARTTIME=$(date '+%s')

# Update cargo-update before using it to update everything else
cargo install-update cargo-update
cargo install-update -ga
tldr --update

ENDTIME=$(date '+%s')
ELAPSED=$(echo "${ENDTIME} - ${STARTTIME}" | bc)
echo "Time elapsed: ${ELAPSED} seconds"
