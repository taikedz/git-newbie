GSETTING_gitnfile=./.gitn

function settings_initialize {
	: ${GSETTING_fetch=true}
	: ${GSETTING_warnmaster=true}

	: ${GSETTING_withtags=false}
	: ${GSETTING_nofetch=false}
	: ${GSETTING_histdiff=false}
	: ${GSETTING_delbranch=true}
	: ${GSETTING_force=false}
}

function settings_load {
	if [[ -f "$GSETTING_gitnfile" ]]; then
		. "$GSETTING_gitnfile"
	fi

	settings_initialize
}
