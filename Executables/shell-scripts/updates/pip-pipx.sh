#!/usr/bin/env dash

start_time=$(date '+%s')

pip3 install -U --user pynvim pipx
pipx upgrade-all
pipx upgrade buku --spec git+https://github.com/jarun/Buku.git
pipx upgrade ddgr --spec git+https://github.com/jarun/ddgr.git
pipx upgrade emoji-fzf --spec git+https://github.com/noahp/emoji-fzf.git
pipx upgrade haxor-news --spec git+https://github.com/donnemartin/haxor-news.git
pipx upgrade howmanypeoplearearound --spec git+https://github.com/schollz/howmanypeoplearearound.git
pipx upgrade httpie --spec git+https://github.com/jakubroztocil/httpie.git
pipx upgrade unimatrix --spec git+https://github.com/will8211/unimatrix.git
pipx upgrade pockyt --spec git+https://github.com/arvindch/pockyt.git
pipx upgrade poku --spec git+https://github.com/shanedabes/poku.git
pipx upgrade ptpython --spec git+https://github.com/prompt-toolkit/ptpython.git
pipx upgrade speedtest-cli --spec git+https://github.com/sivel/speedtest-cli.git
pipx upgrade standardebooks --spec git+https://github.com/standardebooks/tools.git
pipx upgrade thefuck --spec git+https://github.com/nvbn/thefuck.git
pipx upgrade trash-cli --spec git+https://github.com/andreafrancia/trash-cli.git
pipx upgrade tuir --spec git+https://gitlab.com/ajak/tuir.git
pipx upgrade urlscan --spec git+https://github.com/firecat53/urlscan.git
pipx upgrade youtube-dl --spec git+https://github.com/ytdl-org/youtube-dl.git

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
