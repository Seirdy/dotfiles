if [ -z "$PROFILE_SET" ]; then
	# shellcheck source=.profile
	. "$HOME/.profile"
	export PROFILE_SET='zprofile'
fi

