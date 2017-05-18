function action_tag {
	# GITARGS_* -- files, arguments
	
	if [[ "${#GITARGS_arguments[@]}" -gt 0 ]]; then
		local tagname="${GITARGS_arguments[0]}"
		local commitmessage="${GITARGS_arguments[@]:1}"
		gitcall tag "$tagname" -m "$commitmessage"
	else
		gitcall tag --list
	fi
}
