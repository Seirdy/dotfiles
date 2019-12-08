#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"

# youtube-dl manpage and zsh completion
ghq_get_cd https://github.com/ytdl-org/youtube-dl.git \
	&& make youtube-dl.1 \
	&& install -m 644 youtube-dl.1 "$MANPREFIX/man1" \
	&& ./devscripts/zsh-completion.py

# these repos have items symlinked to other places

# weechat-matrix
# shellcheck source=/dev/null
ghq_get_cd https://github.com/poljar/weechat-matrix.git && . ./venv/bin/activate \
	&& pip install -Ur ./requirements.txt \
	&& make install \
	&& deactivate

ghq get -u https://github.com/keith/edit-weechat.git
ghq get -u https://github.com/carnager/clerk.git
# I use this repo's "cantata-dynamic" perl script to generate playlists
ghq get -u https://github.com/CDrummond/cantata.git

# cheat.sh local installation
# update git repo, recreate zsh completion
cd "$HOME/.cheat.sh" \
	&& git pull && git submodule update --init --recursive --force --remote \
	&& sed -e 's#curl -s cheat.sh/:list#cht.sh :list#' "$HOME/.cheat.sh/share/zsh.txt" >"$XDG_CONFIG_HOME/shell_common/zsh/_cht.sh"

# shellcheck source=./cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
