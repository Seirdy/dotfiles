#!/usr/bin/env dash

opam init -n
opam update
opam upgrade

# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"

ghq_get_cd https://github.com/bcpierce00/unison.git \
	&& cd src \
	&& make \
	&& HOME="$OPAM_SWITCH_PREFIX" make install
