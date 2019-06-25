#!/usr/bin/env dash

STARTTIME=$(date '+%s')

npm i -g tree-sitter
npm i -g tree-sitter-bash
npm i -g bash-language-server
npm i -g markdownlint-cli
npm i -g neovim

ENDTIME=$(date '+%s')
ELAPSED=$(echo "${ENDTIME} - ${STARTTIME}" | bc)
echo "Time elapsed: ${ELAPSED} seconds"
