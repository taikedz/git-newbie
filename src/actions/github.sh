function action_github_checkprereqs {
	if ! hasbin curl; then
		faile "Cannot find curl -- abort"
	fi

	if ! hasbin jq; then
		faile "Cannot find jq"
	fi
}

function action_github_jsoncall {
	uname=$(uask "username")

	curl -s -u "$uname" "https://api.github.com/user/repos" -d "$*"
}

function action_githubcreate {
	# GITARGS_* -- files, arguments
	action_github_checkprereqs
	
	if [[ -n "${GITARGS_arguments[*]}" ]]; then
		local githubjson_res="$(action_githubcreate_newrepo "${GITARGS_arguments[@]}")"

		if [[ "$(jq_query .message "$githubjson_res")" =~ failed ]]; then
			faile "Could not create github repo: $(jq_query .errors "$githubjson_res")"
		fi

		action_github_setremote "$githubjson_res"
	else
		faile "No repository specified"
	fi
}

function jq_query {
	local query="$1"; shift
	local stringdata="$*"

	jq "$query" <(echo "$stringdata")
}

function action_githubcreate_newrepo {
	NEWREPO="$1" ; shift
	DESC="$*"

	action_github_jsoncall "{\"name\":\"$NEWREPO\", \"description\":\"$DESC\" }"

}

function action_github_setremote {
	# NOTE - this is highly dependent on the JSON being pretty formatted with
	#  key-value paris being alone on lines

	debuge "$*"

	local cloneurl="$(jq_query .git_url "$*")"

	local defremote="$(action_remote_getremote "origin")"

	if [[ -z "$defremote" ]]; then
		defremote=origin
	else
		defremote=gitnauto
	fi

	action_remote_setremote "$defremote" "$cloneurl"

}
