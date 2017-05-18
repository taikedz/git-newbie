function action_tag {
	# GITARGS_* -- files, arguments
	
	if [[ "${#GITARGS_arguments[@]}" -gt 0 ]]; then
		action_tag_writetag "${#GITARGS_arguments[@]}"
	else
		action_tag_listtags
	fi
}

function action_tag_listtags {
	gitcall tag --list
}

function action_tag_writetag {
	local tagname="$1" ; shift
	local commitmessage="$*"
	gitcall tag "$tagname" -m "$commitmessage"
}
