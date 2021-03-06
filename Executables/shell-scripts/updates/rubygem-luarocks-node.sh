#!/usr/bin/env dash
start_time=$(date '+%s')

# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

# echo "===UPDATE: Upgrading: Lua======="
luarocks install lcf --local
luarocks install --server=https://luarocks.org/dev lua-lsp --local
luarocks install --server=https://luarocks.org/dev croissant --local
luarocks install --server=https://luarocks.org/dev moonscript --local
# echo "===UPDATE: Upgrading: Rubygems======="
gem update --prerelease -V
echo "===UPDATE: Upgrading: npm packages"
# install pnpm if it doesn't already exist,
export TMPDIR=/tmp/pnpm
mkdir -p "$TMPDIR"
command -v pnpm >/dev/null || npm add -g pnpm && rm -rf "${NODE_PATH:?}/lib"
pnpm add -g pnpm
pnpm add -g bash-language-server
pnpm add -g vscode-html-languageserver-bin
pnpm add -g git+https://github.com/croqaz/clean-mark.git
pnpm add -g git+https://github.com/igorshubovych/markdownlint-cli.git
pnpm add -g neovim
pnpm add -g vscode-css-languageserver-bin
pnpm add -g vscode-json-languageserver
pnpm add -g vim-language-server
pnpm add -g dockerfile-language-server-nodejs
pnpm add -g webtorrent-cli
pnpm add -g 'git+https://github.com/mozilla/observatory-cli.git'
pnpm add -g hint
pnpm add -g @hint/configuration-all
pnpm add -g markdown-link-validator
pnpm add -g 'git+https://github.com/GoogleChrome/lighthouse.git'
pnpm add -g 'git+https://github.com/stylelint/stylelint.git'

end_time="$(date '+%s')"
elapsed="$(echo "$end_time - $start_time" | bc)"
echo "Time elapsed: $elapsed seconds"
