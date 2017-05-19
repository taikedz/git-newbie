function action_blame {
	# GITARGS_* -- files, arguments
	
	for thefile in "${GITARGS_allfiles[@]}"; do
		git blame "$thefile" | less
	done
}
