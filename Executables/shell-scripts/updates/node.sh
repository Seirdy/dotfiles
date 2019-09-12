#!/usr/bin/env dash

start_time=$(date '+%s')

# install pnpm if it doesn't already exist,
# and erase the now-obsolete $NODE_PATH/lib directory.
command -v pnpm >/dev/null || npm add -g pnpm && rm -rf "${NODE_PATH:?}/lib"
pnpm add -g pnpm
pnpm add -g bash-language-server
pnpm add -g markdownlint-cli
pnpm add -g neovim

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
