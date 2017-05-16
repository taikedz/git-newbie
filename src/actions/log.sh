function action_log {
	# GITARGS_* -- files, arguments
	
	if [[ -z "${#GITARGS_files}" ]]; then
		action_log_general
	else
		action_log_files
	fi
}

function action_log_general {
	gitcall log
}

function action_log_files {
	for thefile in "${GITARGS_files[@]}"; do
		gitcall log "$thefile"
	done
}
