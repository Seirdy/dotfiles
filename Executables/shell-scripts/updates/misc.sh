#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"

# shellcheck source=/dev/null
ghq_get_cd https://github.com/poljar/weechat-matrix.git && . ./venv/bin/activate \
	&& pip3 install -U requirements.txt \
	&& make install

ghq get -u https://github.com/keith/edit-weechat.git

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
