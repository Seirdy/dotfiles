#!/usr/bin/env dash

ghq_get_cd() {
	if [ -z "$GHQ_ROOT" ]; then
		GHQ_ROOT=$(ghq root)
	fi
	trimmed_url=$(trim-git-url "$1")
	ghq get -u "$1" \
		&& cd "${GHQ_ROOT}/$trimmed_url" \
		&& git submodule update --init --recursive --remote
}

# vi:ft=sh
