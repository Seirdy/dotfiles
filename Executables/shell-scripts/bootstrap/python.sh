#!/usr/bin/env dash

pip3 install -U --user pynvim pipx

# curses mpd client
pipx install 'git+https://github.com/beetbox/beets.git#egg=beets[lyrics]'
pipx install black &
pipx install git+https://github.com/jarun/Buku.git &
pipx install git+https://github.com/kneufeld/consolemd.git &
pipx install git+https://github.com/jarun/ddgr.git &
pipx install git+https://github.com/noahp/emoji-fzf.git
pipx install flake8 &
pipx install git+https://github.com/nicolargo/glances.git &
pipx install git+https://github.com/donnemartin/haxor-news.git &
pipx install git+https://github.com/jakubroztocil/httpie.git &
pipx install mypy &
pipx install git+https://github.com/cykerway/ncmpy.git &
pipx install neovim-remote &
pipx install git+https://github.com/arvindch/pockyt.git &
pipx install git+https://github.com/containers/podman-compose.git &
pipx install git+https://github.com/shanedabes/poku.git &
pipx install proselint &
pipx install pydiatra &
pipx install pydocstyle &
pipx install pygments &
pipx install pyre-check &
pipx install pytest &
pipx install requires.io &
pipx install restructuredtext-lint &
pipx install safety &
pipx install scspell3k &
pipx install git+https://github.com/sivel/speedtest-cli.git &
pipx install sphinx &
pipx install git+https://github.com/standardebooks/tools.git &
pipx install git+https://github.com/nvbn/thefuck.git &
pipx install tox &
pipx install git+https://github.com/andreafrancia/trash-cli.git &
pipx install git+https://gitlab.com/ajak/tuir.git &
pipx install twine &
pipx install ueberzug &
pipx install git+https://github.com/will8211/unimatrix.git
pipx install vim-vint &
pipx install virtualenv &
pipx install xenon &
pipx install git+https://github.com/xonsh/xonsh.git
pipx install yamllint
pipx install git+https://github.com/ytdl-org/youtube-dl.git
pipx install mercurial
pipx install meson # build system for lots of stuff
pipx install --system-site-packages git+https://github.com/prompt-toolkit/ptpython.git &
pipx install --system-site-packages 'python-language-server[all]'
pipx install --system-site-packages --include-deps 'git+https://github.com/prompt-toolkit/ptpython.git#egg=ptpython[ptipython]'
pipx install --system-site-packages 'git+https://github.com/roddhjav/pass-import#egg=pass-import[keepass]'
