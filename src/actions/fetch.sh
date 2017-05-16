function action_fetch {
	# GITARGS_* -- files, arguments
	
	if [[ "$GSETTING_fetch" = true ]]; then
		git fetch "$(gitn_getRemote)"
	fi
}
