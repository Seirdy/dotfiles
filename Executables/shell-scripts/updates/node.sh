#!/usr/bin/env dash

start_time=$(date '+%s')

npm i -g tree-sitter
npm i -g tree-sitter-bash
npm i -g bash-language-server
npm i -g markdownlint-cli
npm i -g neovim

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
