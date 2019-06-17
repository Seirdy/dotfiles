#!/usr/bin/env dash
STARTTIME=$(date '+%s')
cd "$HOME/Executables/shell-scripts/updates"
echo "===UPDATE: Upgrading: PIP3======="
sh ./update-python.sh
echo "===UPDATE: Upgrading: NPM======="
dash ./update-node.sh
echo "===UPDATE: Upgrading: Lua======="
dash ./update-lua.sh
echo "===UPDATE: Upgrading: Rubygems======="
dash ./update-ruby.sh
tldr --update
ENDTIME=$(date '+%s')
ELAPSED=$(calc -p "${ENDTIME} - ${STARTTIME}")
echo "Time elapsed: ${ELAPSED} seconds"
