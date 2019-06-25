#!/usr/bin/env dash

STARTTIME=$(date '+%s')

brew update
brew upgrade
brew cask upgrade

ENDTIME=$(date '+%s')
ELAPSED=$(echo "${ENDTIME} - ${STARTTIME}" | bc)
echo "Time elapsed: ${ELAPSED} seconds"
