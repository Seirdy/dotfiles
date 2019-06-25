#!/usr/bin/env dash

STARTTIME=$(date '+%s')

flatpak repair --user
flatpak update -y --user
flatpak uninstall --unused -y

ENDTIME=$(date '+%s')
ELAPSED=$(echo "${ENDTIME} - ${STARTTIME}" | bc)
echo "Time elapsed: ${ELAPSED} seconds"
