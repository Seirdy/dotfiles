#!/usr/bin/env dash

start_time=$(date '+%s')

pip3 install -U --user git+https://github.com/pipxproject/pipx.git
pip3 install -U --user pynvim
pipx upgrade-all

echo "updating comic-dl"
# shellcheck disable=SC2154
comicdl_dir="$GHQ_ROOT/github.com/Xonshiz/comic-dl"

# shellcheck source=/dev/null
ghq_get_cd https://github.com/Xonshiz/comic-dl.git \
	&& {
		[ -d "$comicdl_dir/venv" ] || virtualenv "$comicdl_dir/venv"
	} \
	&& . "$comicdl_dir/venv/bin/activate" \
	&& python -m pip install -Ur "$comicdl_dir/requirements.txt" \
	&& echo "successfully updated comic-dl"

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
