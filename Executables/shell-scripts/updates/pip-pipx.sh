#!/usr/bin/env dash

start_time=$(date '+%s')

python -m pip install -U --user git+https://github.com/pipxproject/pipx.git
python -m pip install -U --user pynvim
pipx upgrade-all --verbose

update_comicdl() {
	echo "updating comic-dl"
	# shellcheck disable=SC2154
	comicdl_dir="$GHQ_ROOT/github.com/Xonshiz/comic-dl"
	trap "deactivate" EXIT
	# shellcheck source=/dev/null
	ghq_get_cd https://github.com/Xonshiz/comic-dl.git \
		&& {
			[ -d "$comicdl_dir/venv" ] || virtualenv "$comicdl_dir/venv"
		} \
		&& . "$comicdl_dir/venv/bin/activate" \
		&& python -m pip install -Ur "$comicdl_dir/requirements.txt" \
		&& echo "successfully updated comic-dl"
}
# cheat.sh local installation
update_cheatsh() {
	# update git repo, recreate z
	trap "deactivate" EXIT
	# shellcheck source=/dev/null disable=SC2154
	cd "$HOME/.cheat.sh" \
		&& git pull && git submodule update --init --recursive --force --remote \
		&& sed -e 's#curl -s cheat.sh/:list#cht.sh :list#' ./share/zsh.txt >"$XDG_CONFIG_HOME/shell_common/zsh/_cht.sh" \
		&& {
			[ -d "./ve" ] || virtualenv --system-site-packages ./ve # use system python-Levenshtein
		} \
		&& . ./ve/bin/activate \
		&& python -m pip install -Ur ./requirements.txt \
		&& echo "successfully updated cheat.sh local installation"
}

update_comicdl
update_cheatsh

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
