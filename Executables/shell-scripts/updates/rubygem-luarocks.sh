#!/usr/bin/env dash
start_time=$(date '+%s')

echo "===UPDATE: Upgrading: Lua======="
luarocks install lcf --local
luarocks install --server=http://luarocks.org/dev lua-lsp --local
echo "===UPDATE: Upgrading: Rubygems======="
gem update --prerelease -V

end_time=$(date '+%s')
elapsed=$(echo "${end_time} - ${start_time}" | bc)
echo "Time elapsed: ${elapsed} seconds"
