#!/usr/bin/env dash
STARTTIME=$(date '+%s')
cd "$HOME/Executables/shell-scripts/updates"
echo "===UPDATE: Upgrading: PIP3======="
sh ./updatepip3.sh
echo "===UPDATE: Upgrading: NPM======="
dash ./updatenpm.sh
echo "===UPDATE: Upgrading: Lua======="
dash ./updatelua.sh
echo "===UPDATE: Upgrading: Rubygems======="
dash ./updaterubygems.sh
tldr --update
ENDTIME=$(date '+%s')
ELAPSED=$(calc -p "${ENDTIME} - ${STARTTIME}")
echo "Time elapsed: ${ELAPSED} seconds"
