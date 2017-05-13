function action_commit {
	gitcall add "${GITARGS_files[@]}"
	
	if [[ -z "${GITARGS_arguments[*]}" ]]; then
		gitcall commit
	else
		gitcall commit -m "${GITARGS_arguments[*]}"
	fi
}
