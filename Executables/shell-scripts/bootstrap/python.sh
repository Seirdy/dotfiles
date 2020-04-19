#!/usr/bin/env dash

python3 -m ensurepip
python3 -m pip install -U --user pip
python3 -m pip install -U --user pynvim pipx

pipx install virtualenv
pipx install 'git+https://github.com/beetbox/beets.git#egg=beets[lyrics]' &
pipx install git+https://github.com/asciinema/asciinema.git &
pipx install git+https://github.com/aboul3la/Sublist3r.git &
pipx install black &
pipx install git+https://github.com/jarun/Buku.git &
pipx install git+https://github.com/kneufeld/consolemd.git &
pipx install git+https://github.com/jarun/ddgr.git &
pipx install git+https://github.com/noahp/emoji-fzf.git
pipx install flake8 &
pipx install git+https://github.com/donnemartin/haxor-news.git &
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
pipx install xenon &
pipx install git+https://github.com/ihabunek/toot.git &
pipx install git+https://github.com/magicalraccoon/tootstream.git &
pipx install git+https://github.com/xonsh/xonsh.git
pipx install yamllint
pipx install git+https://github.com/ytdl-org/youtube-dl.git
pipx install mercurial
pipx install meson # build system for lots of stuff
# pipx install --system-site-packages git+https://github.com/prompt-toolkit/ptpython.git &
pipx install --system-site-packages 'python-language-server[all]'
pipx inject python-language-server pyls-mypy pyls-black
pipx install --system-site-packages --include-deps 'git+https://github.com/prompt-toolkit/ptpython.git#egg=ptpython[ptipython]'
pipx install --system-site-packages 'git+https://github.com/roddhjav/pass-import#egg=pass-import[keepass]'
pipx install --system-site-packages 'git+https://github.com/qutebrowser/qutebrowser.git'
pipx inject --include-apps ptpython konch
