GSETTING_gitnfile=.gitn

function settings_initialize {
	: ${GSETTING_warnmaster=true}

	: ${GSETTING_withtags=false}
	: ${GSETTING_nofetch=false}
	: ${GSETTING_histdiff=false}
	: ${GSETTING_delbranch=false}
	: ${GSETTING_force=false}
}

function settings_load {
	local settingsfile="$(find_settings)"
	[[ -n "$settingsfile" ]] && . "$settingsfile" || :

	settings_initialize
}

function find_settings {
	if [[ -f "$GSETTING_gitnfile" ]]; then
		echo "$PWD/$GSETTING_gitnfile"

	elif [[ -d .git ]] || [[ "$PWD" = / ]]; then
		# We only want to load settings for the current git project
		return

	else
		# Use a subshell to avoid changing the working directory at main level
		(
		cd ..
		find_settings
		)
	fi
}
