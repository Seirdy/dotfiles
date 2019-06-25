#!/usr/bin/env dash
STARTTIME=$(date '+%s')
echo "===UPDATE: Upgrading: Lua======="
luarocks install lcf --local
luarocks install --server=http://luarocks.org/dev lua-lsp --local
echo "===UPDATE: Upgrading: Rubygems======="
gem update --prerelease -V
ENDTIME=$(date '+%s')
ELAPSED=$(calc -p "${ENDTIME} - ${STARTTIME}")
echo "Time elapsed: ${ELAPSED} seconds"
