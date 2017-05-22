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

	curl -u "$uname" "https://api.github.com/user/repos" -d "$*"
}

function action_githubcreate {
	# GITARGS_* -- files, arguments
	local githubjson_res
	
	if [[ -n "${GITARGS_arguments[*]}" ]]; then
		githubjson_res="$(action_githubcreate_newrepo "${GITARGS_arguments[@]}")"
	else
		faile "No repository specified"
	fi
}

function action_githubcreate_newrepo {
	NEWREPO="$1" ; shift
	DESC="$*"

	action_github_jsoncall "{\"name\":\"$NEWREPO\", \"description\":\"$DESC\" }"

}
