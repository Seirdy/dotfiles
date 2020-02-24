#!/usr/bin/env dash
start_time=$(date '+%s')

# shellcheck source=./cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

# echo "===UPDATE: Upgrading: Lua======="
luarocks install lcf --local
luarocks install --server=http://luarocks.org/dev lua-lsp --local
# echo "===UPDATE: Upgrading: Rubygems======="
gem update --prerelease -V
echo "===UPDATE: Upgrading: npm packages"
# install pnpm if it doesn't already exist,
export TMPDIR=/tmp/pnpm
mkdir -p $TMPDIR
command -v pnpm >/dev/null || npm add -g pnpm && rm -rf "${NODE_PATH:?}/lib"
pnpm add -g pnpm
pnpm add -g bash-language-server
pnpm add -g markdownlint-cli
pnpm add -g neovim
pnpm add -g vscode-css-languageserver-bin
pnpm add -g vscode-json-languageserver
pnpm add -g vim-language-server
pnpm add -g dockerfile-language-server-nodejs

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
