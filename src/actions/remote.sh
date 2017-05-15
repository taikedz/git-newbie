function action_remote_getremote {
	gitcall remote -v|egrep "^$1"
}


function action_remote_setremote {
	if [[ -z "${2:-}" ]]; then
		action_remote_getremote "$1"
	else
		local remstring="$(action_remote_getremote "$1")"

		if [[ -z "$remstring" ]]; then
			gitcall remote add "$1" "$2"
		else
			gitcall remote set-url "$1" "$2"
		fi
	fi
}

function action_remote {
	# GITARGS_* -- files, arguments
	
	if [[ -z "${GITARGS_arguments[*]}" ]]; then
		gitcall remote -v
	else
		action_remote_setremote "${GITARGS_arguments[@]}"
	fi
}
