function action_stash {
	# GITARGS_* -- files, arguments
	
	gitcall stash "${GITARGS_arguments[@]}"
}
