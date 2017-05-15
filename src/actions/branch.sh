function action_branch {
	# GITARGS_* -- files, arguments

	if [[ -z "${GITARGS_arguments[*]}" ]]; then
		gitcall branch --list
	else
		local bopt=
		if [[ -z "$(git branch --list|egrep "^..${GITARGS_arguments[0]}$")" ]]; then
			bopt=-b
		fi
		gitcall checkout $bopt "${GITARGS_arguments[0]}"
	fi
}
