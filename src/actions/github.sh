#%include bincheck.sh

function action_github_checkprereqs {
	if ! bincheck:has curl; then
		out:fail "Cannot find curl -- abort"
	fi

	if ! bincheck:has jq; then
		out:fail "Cannot find jq"
	fi
}

function action_github_jsoncall {
	local uname="$1"; shift

	curl -s -u "$uname" "https://api.github.com/user/repos" -d "$*"
}

function action_githubcreate {
	# GITARGS_* -- files, arguments
	action_github_checkprereqs

	local reponame="${GITARGS_arguments[0]}"
	local username=$(askuser:ask "username")
	
	if [[ -n "${GITARGS_arguments[*]}" ]]; then
		local githubjson_res="$(action_githubcreate_newrepo "$username" "$reponame" "${GITARGS_arguments[*]:1}")"

		if [[ "$(jq_query .message "$githubjson_res")" =~ failed ]]; then
			out:fail "Could not create github repo: $(jq_query .errors "$githubjson_res")"
		fi

		action_github_setremote "$username" "$reponame"
	else
		out:fail "No repository specified"
	fi
}

function jq_query {
	local query="$1"; shift
	local stringdata="$*"

	jq "$query" <(echo "$stringdata")
}

function action_githubcreate_newrepo {
	local username="$1"; shift
	local newrepo="$1" ; shift
	local repodesc="$*"

	out:debug "User: $username ; repo: $newrepo ; Description: $repodesc"

	action_github_jsoncall "$username" "{\"name\":\"$newrepo\", \"description\":\"$repodesc\" }"

}

function action_github_setremote {
	local username="$1"; shift
	local reponame="$1"; shift

	local cloneurl="ssh://git@github.com/$username/$reponame"
	local defremote="$(action_remote_getremote "origin")"

	if [[ -z "${defremote:-}" ]]; then
		defremote="origin"
	else
		defremote="gitnauto"
	fi

	action_remote_setremote "$defremote" "$cloneurl"
}
