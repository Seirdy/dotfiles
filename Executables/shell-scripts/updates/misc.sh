#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"

# shellcheck source=/dev/null
ghq_get_cd https://github.com/poljar/weechat-matrix.git && . ./venv/bin/activate \
	&& pip3 install -U requirements.txt \
	&& make install

# these repos have items symlinked to other places

ghq get -u https://github.com/keith/edit-weechat.git
ghq get -u https://github.com/carnager/clerk.git
# I use this repo's "cantata-dynamic" perl script to generate playlists
ghq get -u https://github.com/CDrummond/cantata.git

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
