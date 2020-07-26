#!/usr/bin/env dash

start_time=$(date '+%s')

# shellcheck source=/home/rkumar/.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"

stack_local() {
	stack --local-bin-path="$HOME/Executables/stack/bin" "$@"
}

if [ "$THREADS" -gt 6 ]; then
	echo "using multiple threads"
	# using too many threads can consume a LOT of memory.
	ghc_opts="-O2 -optc-O3 -threaded -j2 +RTS -A32m -RTS"
else
	ghc_opts='-O2 -optc-O3 -threaded +RTS -A32m -RTS'
fi

stack_local_optimized() {
	stack_local "$@" --ghc-options="$ghc_opts"
}

stack_install_git() {
	ghq_get_cd "$1" || return 1
	if [ -f ./stack-nightly.yaml ]; then
		STACK_YAML=./stack-nightly.yaml
	elif [ -f ./stack.yaml ]; then
		STACK_YAML=./stack.yaml
	fi
	export STACK_YAML
	shift
	stack_local setup \
		&& stack_local_optimized install "$@"
}

stack_install_git_nightly() {
	ghq_get_cd "$1" || return 1
	if [ -f ./stack-nightly.yaml ]; then
		STACK_YAML=./stack-nightly.yaml
	elif [ -f ./stack.yaml ]; then
		STACK_YAML=./stack.yaml
	fi
	export STACK_YAML
	shift
	stack_local --resolver=nightly setup \
		&& stack_local_optimized --resolver=nightly install "$@"
}

stack_install_nightly_fallback() {
	stack_install_git_nightly "$@" \
		|| {
			echo 'Failed to update with nightly resolver; trying with specified resolver' \
				&& stack_install_git "$@"
		}
}

# update hackage data
stack_local update
stack_install_nightly_fallback https://github.com/commercialhaskell/stack.git

#
# Pandoc and friends
#

stack_install_git https://github.com/jgm/pandoc.git --flag 'pandoc:embed_data_files'
# pandoc's manpage
cd "$GHQ_ROOT/github.com/jgm/pandoc" \
	&& make man/pandoc.1 \
	&& install -m 0644 "man/pandoc.1" "$MANPREFIX/man1"

stack_install_nightly_fallback https://github.com/owickstrom/pandoc-emphasize-code.git
stack_install_nightly_fallback https://github.com/lierdakil/pandoc-crossref.git

export CFLAGS="$CFLAGS_LTO"
export CXXFLAGS="$CFLAGS_LTO"
export CPPFLAGS="$CXXFLAGS"
# Pandoc filters
stack_install_git https://github.com/jgm/pandoc-citeproc.git --flag 'pandoc-citeproc:embed_data_files'
stack_install_nightly_fallback https://github.com/owickstrom/pandoc-include-code.git

#
# Stuff besides pandoc
#

# Shell script linter
stack_install_nightly_fallback https://github.com/koalaman/shellcheck.git
cd "$GHQ_ROOT/koalaman/shellcheck" \
	&& pandoc -s -f markdown-smart -t man shellcheck.1.md -o shellcheck.1 \
	&& install -m 0644 shellcheck.1 "$MANPREFIX/man1"
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
