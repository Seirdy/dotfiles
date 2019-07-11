#!/usr/bin/env zsh

start_time=$(date '+%s')

. "$HOME/.zshrc"

zplugin self-update
zplugin update --all
zplugin module build

end_time=$(date '+%s')
elapsed=$(echo "${end_time} - ${start_time}" | bc)
echo "Time elapsed: ${elapsed} seconds"
