function action_github_checkprereqs {
	if ! hasbin curl; then
		faile "Cannot find curl -- abort"
	fi

	if ! hasbin jq; then
		faile "Cannot find jq"
	fi
}

function action_github_jsoncall {
	local uname="$1"; shift

	local targetpath="user/repos"

	if [[ "$uname" =~ @ ]]; then
		targetpath="orgs/${uname#*@}/repos"
		uname="${uname%@*}"
	fi

	debuge curl -s -u "$uname" "https://api.github.com/$targetpath" -d "$*"
	breake "New repo for $uname at $targetpath with data [$*]"
	curl -s -u "$uname" "https://api.github.com/$targetpath" -d "$*"
}

function action_githubcreate {
	# GITARGS_* -- files, arguments
	action_github_checkprereqs

	if [[ -n "${GITARGS_arguments[*]}" ]]; then
		local reponame="${GITARGS_arguments[0]}"; shift
		[[ -z "${username:-}" ]] && username="$(uask "username")"

		[[ -n "$reponame" ]] || faile "No repo name"
		[[ -n "$username" ]] || faile "No username supplied"
	
		local githubjson_res="$(action_githubcreate_newrepo "$username" "$reponame" "${GITARGS_arguments[*]:1}")"

		debuge "Result: $githubjson_res"

		if [[ "$(jq_query .message "$githubjson_res")" =~ failed ]]; then
			faile "Could not create github repo: $(jq_query .errors "$githubjson_res")"
		fi

		action_github_setremote "$username" "$reponame"
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
	local username="$1"; shift
	local newrepo="$1" ; shift
	local repodesc="$*"

	debuge "User: $username ; repo: $newrepo ; Description: $repodesc"

	action_github_jsoncall "$username" "{\"name\":\"$newrepo\", \"description\":\"$repodesc\" }"

}

function action_github_setremote {
	local username="$1"; shift
	local reponame="$1"; shift

	local cloneurl="ssh://git@github.com/${username#*@}/$reponame"
	local defremote="$(action_remote_getremote "origin")"

	if [[ -z "${defremote:-}" ]]; then
		defremote="origin"
	else
		defremote="gitnauto"
	fi

	action_remote_setremote "$defremote" "$cloneurl"
}
