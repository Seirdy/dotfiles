#!/usr/bin/env dash
unset GTK_THEME
if [ "$PROFILE_SET" != 1 ]; then
	# shellcheck source=startup.sh
	. "$HOME/startup.sh"
	export PROFILE_SET='profile'
fi
