function action_pull {
	# GITARGS_* -- files, arguments
	
	local remote=$(gitn_getRemote "${GITARGS_arguments[@]}")
	local branch=$(gitn_getBranch "${GITARGS_arguments[@]}")

	gitcall pull "$remote" "$branch"
}
