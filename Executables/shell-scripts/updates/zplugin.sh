#!/usr/bin/env zsh

start_time=$(date '+%s')

. "$HOME/.zshrc"
# shellcheck source=./cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

zinit self-update
zinit update --all
zinit module build

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
