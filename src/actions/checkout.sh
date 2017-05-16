function action_checkout {
	# GITARGS_* -- files, arguments
	
	if [[ "${#GITARGS_files[@]}" = 1 ]]; then
		gitcall checkout "${GITARGS_files[0]}"
	else
		faile "You must specify exactly one object for checkout."
	fi
}
