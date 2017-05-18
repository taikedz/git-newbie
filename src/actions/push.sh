function action_push {
	# GITARGS_* -- files, arguments

	if [[ "${GSETTING_withtags}" = "true" ]]; then
		action_push_tags
	else
		action_push_changes
	fi
}

function action_push_changes {
	breake "$GITARGS_arguments"
	local remote=$(gitn_getRemote "${GITARGS_arguments[@]}")
	local branch=$(gitn_getBranch "${GITARGS_arguments[@]}")

	infoe "Pushing $branch to $remote/$branch"
	gitcall push "$remote" "$branch"
}

function action_push_tags {
	local remote=$(gitn_getRemote "${GITARGS_arguments[@]}")

	gitcall push "$remote" --tags
}
