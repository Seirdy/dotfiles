#!/usr/bin/env dash
STARTTIME=$(date '+%s')

flatpak update -y --user
flatpak uninstall --unused -y

ENDTIME=$(date '+%s')
ELAPSED=$(calc -p "${ENDTIME} - ${STARTTIME}")
echo "Time elapsed: ${ELAPSED} seconds"