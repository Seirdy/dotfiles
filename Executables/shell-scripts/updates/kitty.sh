#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"

ghq_get_cd https://github.com/kovidgoyal/kitty.git

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
