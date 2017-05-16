function action_branch {
	# GITARGS_* -- files, arguments

	if [[ -z "${GITARGS_arguments[*]}" ]]; then
		gitcall branch --list
	else
		if [[ "$GSETTING_delbranch" = true ]]; then
			action_branch_delete "${GITARGS_arguments[0]}"
		else

			action_branch_switchto "${GITARGS_arguments[0]}"
		fi
	fi
}

function action_branch_hasbranch {
	[[ -n "$(git branch --list|egrep "^..$1$")" ]]
}

function action_branch_delete {
	if action_branch_hasbranch "$1"; then
		local mode="-d"
		if [[ "$GSETTING_force" = true ]]; then
			mode="-D"
		fi
		gitcall branch "$mode" "$1"
	fi
}

function action_branch_switchto {
	local bopt=
	if ! action_branch_hasbranch "$1"; then
		bopt=-b
	fi

	stashpop stash
	gitcall checkout $bopt "$1"
	stashpop pop
}

function stashpop {
	#if [[ "$GSETTING_stashpop" != true ]]; then
	#	return
	#fi

	if [[ "$1" = stash ]]; then
		STASHTEMP="$(mktemp)"
		gitcall stash > "$STASHTEMP"
	elif [[ "$1" = pop ]]; then
		if ! grep -q "No local changes" "$STASHTEMP"; then
			gitcall stash pop
		fi
	else
		faile "Invalid stashpop operation"
	fi
}
