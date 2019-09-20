#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=~/.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"

stack_local() {
	stack --local-bin-path="$HOME/Executables/stack/bin" "$@"
}
stack_install() {
	stack_local install "$@"
}

stack_install_git() {
	ghq_get_cd "$1" \
		&& STACK_YAML="./stack.yaml" stack_local --resolver nightly install
}

stack_local config set resolver nightly
stack_local upgrade
stack_local update
stack_install_git https://github.com/jgm/pandoc.git
stack_install_git https://github.com/jgm/pandoc-citeproc.git
stack_install_git https://github.com/koalaman/shellcheck.git
stack_install_git https://github.com/owickstrom/pandoc-include-code.git
stack_install_git https://github.com/lierdakil/pandoc-crossref.git
stack_install_git https://github.com/digital-asset/ghcide.git
stack_install_git https://github.com/awgn/cgrep.git

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
