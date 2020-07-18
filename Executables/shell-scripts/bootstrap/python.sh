#!/usr/bin/env dash

# the only 3 packages packages installed outside a virtualenv: pip, pynvim, pipx

python3 -m ensurepip
python3 -m pip install -U --user pip
python3 -m pip install -U --user pynvim pipx

pipx_pypy() {
	if [ "$(pypy3 --version | sed 1q | awk '{print $2}' | cut -d'.' -f2)" -ge 6 ]; then
		pipx install --python pypy3 "$@"
	else
		pipx install "$@"
	fi
}

parallel pipx_pypy ::: \
	git+https://github.com/asciinema/asciinema.git \
	git+https://github.com/donnemartin/haxor-news.git \
	git+https://github.com/ihabunek/toot.git \
	git+https://github.com/jarun/Buku.git \
	git+https://github.com/jarun/ddgr.git \
	git+https://github.com/magicalraccoon/tootstream.git \
	git+https://github.com/orf/gping.git \
	git+https://github.com/sivel/speedtest-cli.git \
	git+https://github.com/will8211/unimatrix.git \
	git+https://github.com/ytdl-org/youtube-dl.git \
	git+https://gitlab.com/ajak/tuir.git

parallel pipx install --system-site-packages ::: \
	afdko mypy pylint neovim-remote pytest mercurial meson pytype pyre-check \
	'git+https://git.sr.ht/~seirdy/clogstats#egg=clogstats[forecasting]' \
	'git+https://github.com/beetbox/beets.git#egg=beets[thumbnails,mpdstats,lyrics,chroma,absubmit,embedart,fetchart,lastgenre,replaygain]' \
	'git+https://github.com/prompt-toolkit/ptpython.git#egg=ptpython[ptipython]' \
	git+https://github.com/master-of-zen/Av1an.git \
	git+https://github.com/cykerway/ncmpy.git \
	git+https://github.com/qutebrowser/qutebrowser.git \
	git+https://github.com/nicolargo/glances.git \
	git+https://github.com/standardebooks/tools.git

pipx inject --include-apps ptpython konch

parallel pipx install ::: \
	git+https://github.com/containers/podman-compose.git \
	flake8 black isort pre-commit proselint pydiatra pydocstyle pygments \
	requires.io restructuredtext-lint safety scspell3k sphinx \
	tox vim-vint virtualenv xenon yamllint \
	git+https://github.com/aboul3la/Sublist3r.git \
	git+https://github.com/andreafrancia/trash-cli.git \
	git+https://github.com/arvindch/pockyt.git \
	git+https://github.com/noahp/emoji-fzf.git \
	git+https://github.com/nvbn/thefuck.git \
	git+https://github.com/shanedabes/poku.git \
	git+https://github.com/xonsh/xonsh.git
