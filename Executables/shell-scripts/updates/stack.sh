#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"

stack_local() {
	stack --local-bin-path="$HOME/Executables/stack/bin" "$@"
}

stack_install_git() {
	ghq_get_cd "$1" \
		&& STACK_YAML="./stack.yaml" stack_local setup \
		&& STACK_YAML="./stack.yaml" stack_local install
}

stack_install_git_nightly() {
	ghq_get_cd "$1" \
		&& STACK_YAML="./stack.yaml" stack_local --resolver=nightly setup \
		&& STACK_YAML="./stack.yaml" stack_local --resolver=nightly install
}

stack_install_nightly_fallback() {
	stack_install_git_nightly "$1" \
		|| {
			echo "Failed to update with nightly resolver; trying with specified resolver" \
				&& stack_install_git "$1"
		}
}

stack_local config set resolver nightly
stack_local upgrade
stack_local update

# Pandoc and friends
stack_install_nightly_fallback https://github.com/jgm/pandoc.git
# Pandoc filters
stack_install_nightly_fallback https://github.com/jgm/pandoc-citeproc.git
stack_install_nightly_fallback https://github.com/owickstrom/pandoc-include-code.git
stack_install_nightly_fallback https://github.com/lierdakil/pandoc-crossref.git
stack_install_nightly_fallback https://github.com/owickstrom/pandoc-emphasize-code.git

# Shell script linter
stack_install_nightly_fallback https://github.com/koalaman/shellcheck.git
# Dockerfile linter
stack_install_nightly_fallback https://github.com/hadolint/hadolint.git

# Haskell language server; faster than haskell-ide-engine
ghq_get_cd https://github.com/digital-asset/ghcide.git \
	&& STACK_YAML="./stack88.yaml" stack_local setup \
	&& STACK_YAML="./stack88.yaml" stack_local install
# source code grepper
stack_install_nightly_fallback https://github.com/awgn/cgrep.git

# pdf management
stack_install_nightly_fallback https://github.com/2mol/pboy.git

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
