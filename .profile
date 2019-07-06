#!/usr/bin/env dash
if [ "$PROFILE_SET" != 1 ]; then
	# shellcheck source=startup.sh
	. "$HOME/startup.sh"
	export PROFILE_SET=3
fi
