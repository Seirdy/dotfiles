#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=/home/rkumar/.config/shell_common/functions_ghq.sh
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

# youtube-dl manpage and zsh completion
ghq_get_cd https://github.com/ytdl-org/youtube-dl.git \
	&& make youtube-dl.1 \
	&& install -m 644 youtube-dl.1 "$MANPREFIX/man1" \
	&& ./devscripts/zsh-completion.py

# weechat-matrix
# shellcheck source=/dev/null
ghq_get_cd https://github.com/poljar/weechat-matrix.git && . "$WEECHAT_HOME/python/venv/bin/activate" \
	&& pip install -Ur ./requirements.txt --user \
	&& make install \
	&& deactivate

#
# these repos have items symlinked to other places
#

ghq get -u git@git.sr.ht:~seirdy/mpd-scripts
# some launcher scripts of mine
ghq_get_cd git@git.sr.ht:~seirdy/term-dmenu && make install

# mpv scripts symlinked to places in ~/.config/mpv/
ghq get -u https://github.com/mpv-player/mpv.git
ghq get -u https://github.com/occivink/mpv-scripts.git
ghq get -u https://github.com/tomoe-mami/weechat-scripts.git
ghq get -u https://github.com/Dudemanguy/mpv-manga-reader.git
ghq get -u https://github.com/bjin/mpv-prescalers.git
ghq get -u https://github.com/bloc97/Anime4K.git
ghq get -u https://github.com/classicjazz/mpv-config.git
ghq get -u https://github.com/jgreco/mpv-youtube-quality.git
# weechat scripts
ghq get -u https://github.com/keith/edit-weechat.git
ghq get -u https://github.com/s3rvac/weechat-notify-send.git
# clerk.pl symlinked to ~/.local/bin/clerk
ghq get -u https://github.com/carnager/clerk.git \
	&& cpanm --installdeps "$GHQ_ROOT/github.com/carnager/clerk"
# I use this repo's "cantata-dynamic" perl script to generate playlists
ghq get -u https://github.com/CDrummond/cantata.git

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
