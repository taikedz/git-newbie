function action_push {
	# GITARGS_* -- files, arguments
	
	local remote=$(gitn_getRemote "${GITARGS_arguments[@]}")
	local branch=$(gitn_getBranch "${GITARGS_arguments[@]}")

	gitcall push "$remote" "$branch"

	if [[ "${GSETTING_withtags}" = "true" ]]; then
		gitcall push "$remote" --tags
	fi
		
}
