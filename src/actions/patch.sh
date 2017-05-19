function action_patch {
	# gitn -patch BRANCH [PATCHFILE]
	# this will create a single patch file of the current branch, relative to the remote branch

	# gitn -patch apply PATCHFILE
	# applies patch to current branch
	
	if [[ "${ARGS_arguments[0]}" = apply ]]; then
		action_patchapply "${ARGS_arguments[@]:1}"
	else
		action_patchfor_branch "${ARGS_arguments[@]}"
	fi
}

function action_patch_apply {
	local patchfile="$1"; shift

	if [[ ! -f "$patchfile" ]]; then
		faile "No such file $patchfile"
	fi

	gitcall apply --check "$patchfile"

	uconfirm "Proceed ?" || faile "Aborted"

	gitcall am --signoff < "$patchfile"
}

function action_patch_branch {
	local basebranch="$1"; shift
	local thisbranch="$(gitn_getBranch)"

	local outfile="$1"; shift
	if [[ -z "$outfile" ]]; then
		outfile="$thisbranch.patch"
	fi

	if [[ "$thisbranch" = "$basebranch" ]]; then
		faile "You are on $thisbranch and trying to make a patch from $basebranch. You cannot create a patch from the same branch."
	fi

	gitcall format-patch "$basebranch" --stdout > "$outfile"
}
