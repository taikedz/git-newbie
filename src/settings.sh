GSETTING_gitnfile=./.gitn

function settings_initialize {
	#: ${GSETTING_=""}

	: ${GSETTING_fetch=true}
	: ${GSETTING_warnmaster=true}
}

function settings_load {
	if [[ -f "$GSETTING_gitnfile" ]]; then
		. "$GSETTING_gitnfile"
	fi

	settings_initialize
}
