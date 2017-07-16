function action_log {
	# GITARGS_* -- files, arguments
	
	if [[ "${#GITARGS_allfiles[@]}" -lt 1 ]]; then
		action_log_general
	else
		action_log_files
	fi
}

function action_log_general {
	gitcall log --name-only
}

function action_log_files {
	for thefile in "${GITARGS_allfiles[@]}"; do
		infoe "Log info for $thefile"
		gitcall log "$thefile"
	done
}
