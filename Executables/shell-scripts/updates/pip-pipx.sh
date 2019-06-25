#!/usr/bin/env dash

STARTTIME=$(date '+%s')

pip3 install -U --user pynvim pipx
pipx upgrade-all

ENDTIME=$(date '+%s')
ELAPSED=$(echo "${ENDTIME} - ${STARTTIME}" | bc)
echo "Time elapsed: ${ELAPSED} seconds"
