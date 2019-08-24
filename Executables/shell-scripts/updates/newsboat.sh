#!/usr/bin/env dash

start_time=$(date '+%s')

newsboat_dir="$HOME/Downloads/gitclone/newsboat"
if [ -d "$newsboat_dir" ]; then
	cd "$newsboat_dir" || exit
	git pull
else
	cd $(dirname "$newsboat_dir") || exit
	git clone "https://github.com/newsboat/newsboat"
	cd newsboat || exit
fi

make install prefix="$HOME/.local"

end_time=$(date '+%s')
elapsed=$(echo "${end_time} - ${start_time}" | bc)
echo "Time elapsed: ${elapsed} seconds"
