#!/usr/bin/env dash

start_time=$(date '+%s')

zsh_zplg() {
	zsh -ic "zplugin $@"
}

zsh_zplg self-update
zsh_zplg update --all
zsh_zplg module build

end_time=$(date '+%s')
elapsed=$(echo "${end_time} - ${start_time}" | bc)
echo "Time elapsed: ${elapsed} seconds"
