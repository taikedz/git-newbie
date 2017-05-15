function action_push {
	# GITARGS_* -- files, arguments
	
	local remote=$(gitn_getRemote)
	local branch=$(gitn_getBranch)

	gitcall push "$remote" "$branch"
}
