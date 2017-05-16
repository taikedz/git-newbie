function action_branch {
	# GITARGS_* -- files, arguments

	if [[ -z "${GITARGS_arguments[*]}" ]]; then
		gitcall branch --list
	else
		local bopt=
		if [[ -z "$(git branch --list|egrep "^..${GITARGS_arguments[0]}$")" ]]; then
			bopt=-b
		fi

		stashpop stash
		gitcall checkout $bopt "${GITARGS_arguments[0]}"
		stashpop pop
	fi
}

function stashpop {
	if [[ "$GSETTING_stashpop" != true ]]; then
		return
	fi

	if [[ "$1" = stash ]]; then
		gitcall stash
	elif [[ "$2" = pop ]]; then
		gitcall pop
	else
		faile "Invalid stashpop operation"
	fi
}
