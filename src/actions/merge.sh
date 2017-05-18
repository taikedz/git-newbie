function action_merge {
	# GITARGS_* -- files, arguments
	#merge from

	local frombranch="${GITARGS_arguments[0]}"

	if [[ -z "$frombranch" ]]; then faile "You need to specify a branch to pull merges from"; fi

	gitcall merge "$frombranch"

}

# "Merge" pulls from another branch to the current branch
# To do update, we need to switch - our original branch is then the "from" branch

function action_update {
	#merge to
	local tobranch="${GITARGS_arguments[0]}"

	if [[ -z "$tobranch" ]]; then faile "You need to specify a branch to push merges to."; fi

	local frombranch="$(gitn_getBranch)"
	if [[ -z "$frombranch" ]]; then
		faile "Not a git repository"
	fi

	GSETTING_stashswitch_impede=true # Turn off stashing when using switchto

	stashpop stash || faile "Could not stash changes"
	action_branch_switchto "$tobranch" || faile "Could not switch"

	gitcall merge "$frombranch" || faile "Resolve issues"

	action_branch_switchto "$frombranch" || faile "Could not return to branch"
	stashpop pop
}
