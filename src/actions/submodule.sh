function action_submodule {
	# GITARGS_* -- files, arguments

	local moduleurl="${GITARGS_arguments[0]}"

	gitcall submodule add "$moduleurl"
}
