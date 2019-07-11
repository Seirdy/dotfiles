#!/usr/bin/env dash

start_time=$(date '+%s')

kitty_dir="$HOME/Downloads/gitclone/kitty"
if [ -d "$kitty_dir" ]; then
	cd "$kitty_dir" || exit
	git pull
else
	cd "$(dirname $kitty_dir)" || exit
	git clone "https://github.com/kovidgoyal/kitty.git"
	cd kitty || exit
fi

if [ "$MACHINE" = 'Linux' ]; then
	echo 'Building kitty for Linux'
	pwd
	python3 ./setup.py linux-package --prefix="$HOME/.local" --update-check-interval=0
elif [ "$MACHINE" = 'Darwin' ]; then
	echo 'Building kitty for macOS'
	python3 setup.py kitty.app --update-check-interval=0
fi

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
