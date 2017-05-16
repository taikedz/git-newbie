function action_release {
	# GITARGS_* -- files, arguments

	local versionname="${GITARGS_arguments[0]}"
	local releasemessage="${GITARGS_arguments[@]:1}"

	gitcall tag -m "$releasemessage" "$versionname"

	if [[ -z "$(git status|grep modified:)" ]]; then
		local thisbranch="$(gitn_getBranch)"

		if [[ "$thisbranch" = master ]]; then
			return
		fi

		action_branch_switchto master
		gitcall merge "$thisbranch"
		action_branch_switchto "$thisbranch"
	fi
}
