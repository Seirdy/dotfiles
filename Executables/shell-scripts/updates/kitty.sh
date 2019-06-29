#!/usr/bin/env dash

kitty_dir="$HOME/Downloads/gitclone/kitty"
if [ -d "$kitty_dir" ]; then
	cd "$kitty_dir"
	git pull
else
	cd "$(dirname $kitty_dir)"
	git clone "https://github.com/kovidgoyal/kitty.git"
	cd kitty
fi

if [ "$MACHINE" = 'Linux' ]; then
	echo 'Building kitty for Linux'
	pwd
	python3 ./setup.py linux-package --prefix="$HOME/.local" --update-check-interval=0
elif [ "$MACHINE" = 'Darwin' ]; then
	echo 'Building kitty for macOS'
	python3 setup.py kitty.app --update-check-interval=0
fi
