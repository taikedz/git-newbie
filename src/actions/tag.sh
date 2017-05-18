function action_tag {
	# GITARGS_* -- files, arguments
	
	if [[ "${#arguments[@]}" -gt 0 ]]; then
		local tagname="${arguments[0]}"
		local commitmessage="${arguments[@]:1}"
		gitcall tag "$tagname" -m "$commitmessage"
	else
		gitcall tag --list
	fi
}
