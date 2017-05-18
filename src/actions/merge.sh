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
	infoe "We will return to $frombranch"

	action_branch "$tobranch"   || faile "Cannot update '$tobranch'"
	gitcall merge "$frombranch" || faile "Resolve issues"
	action_branch "$frombranch" || faile "You may still be on '$tobranch'"
}
