GSETTING_gitnfile=./.gitn

function settings_initialize {
	: ${GSETTING_warnmaster=true}

	: ${GSETTING_withtags=false}
	: ${GSETTING_nofetch=false}
	: ${GSETTING_histdiff=false}
	: ${GSETTING_delbranch=false}
	: ${GSETTING_force=false}
}

function settings_load {
	settings_bubbleup

	settings_initialize
}

function settings_bubbleup {
	if [[ -f "$GSETTING_gitnfile" ]]; then
		. "$GSETTING_gitnfile"

	elif [[ -d .git ]] || [[ "$PWD" = / ]]; then
		# We only want to load settings for the current git project
		return

	else
		# Use a subshell to avoid changing the working directory at main level
		(
		cd ..
		settings_bubbleup
		)
	fi
}
