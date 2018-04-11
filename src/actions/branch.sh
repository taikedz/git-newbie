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

function git_repo_is_clean {
	(gitcall status | grep -q 'nothing to commit') && return 0
	return 1
}

function action_branch_switchto {
	local bopt=
	if ! action_branch_hasbranch "$1"; then
		bopt=-b
	fi

	# If clean, don't do undeterministic stash pushing and popping !
	git_repo_is_clean
	local startedclean="$?"

	[[ "$startedclean" -gt 0 ]] && {
		uconfirm "There are uncommitted changes. Stash, switch and pop?" || out:fail "Aborted - no changes were made."
	} || :

	[[ "$GSETTING_stashswitch_impede" = true ]] || [[ "$startedclean" -lt 1 ]] || stashpop stash

	gitcall checkout $bopt "$1"
	
	[[ "$GSETTING_stashswitch_impede" = true ]]  || [[ "$startedclean" -lt 1 ]] || stashpop pop
}

function stashpop {
	if [[ "$1" = stash ]]; then
		STASHTEMP="$(mktemp)"
		gitcall stash > "$STASHTEMP"
		debuge "Stash data : $(cat "$STASHTEMP")"
	elif [[ "$1" = pop ]]; then
		if ! grep -q "No local changes" "$STASHTEMP"; then
			debuge "Popping stash"
			gitcall stash pop
		fi
	else
		out:fail "Invalid stashpop operation"
	fi
}
