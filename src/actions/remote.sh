function action_remote_getremote {
	gitcall remote -v|egrep "^$1"
}


function action_remote_setremote {
	local remote="${1:-}"; shift
	local urlpat="${1:-}"; shift
	local urlstart="${urlpat:0:2}"

	if [[ -z "${urlpat:-}" ]]; then
		action_remote_getremote "$remote"
	else
		local remstring="$(action_remote_getremote "$remote"|head -n 1|sed -r 's/\s+/ /'|cut -d' ' -f2)"

		if [[ -z "$remstring" ]]; then
			if [[ "$urlstart" != 's/' ]]; then
				gitcall remote add "$remote" "$urlpat"
			else
				faile "Remote $remote is not defined yet."
			fi
		else
			if [[ "$urlstart" = s/ ]]; then
				gitcall remote set-url "$remote" "$(echo "$remstring"|sed -r -e "$urlpat")"
			else
				gitcall remote set-url "$remote" "$urlpat"
			fi
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
