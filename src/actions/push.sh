function action_push {
	# GITARGS_* -- files, arguments
	
	local remote=$(gitn_getRemote "${GITARGS_arguments[@]}")
	local branch=$(gitn_getBranch "${GITARGS_arguments[@]}")

	gitcall push "$remote" "$branch"
}
