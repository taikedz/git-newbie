function action_fetch {
	# GITARGS_* -- files, arguments
	
	if [[ "$GSETTING_nofetch" != true ]]; then
		git fetch # "$(gitn_getRemote)"
	fi
}
