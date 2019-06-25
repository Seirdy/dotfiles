#!/usr/bin/env dash

STARTTIME=$(date '+%s')

zsh_zplg() {
	zsh -ic "zplugin $@"
}

zsh_zplg self-update
zsh_zplg update --all
zsh_zplg module build

ENDTIME=$(date '+%s')
ELAPSED=$(echo "${ENDTIME} - ${STARTTIME}" | bc)
echo "Time elapsed: ${ELAPSED} seconds"
