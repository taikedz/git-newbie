function gitn_choose_branch {
	askuser:choose "Which branch" "$(git branch --list 2>&1|sed -r 's/^..//')"
}

### git_getRemote and git_getBranch Usage:bbuild
#
# We are making the REMOTE optional, hence the slightly confusing implementation
#
# 	git command BRANCH
# 	git command REMOTE BRANCH
#
###

function gitn_getRemote {
	out:break "get remote $*"

	if [[ -z "${2:-}" ]]; then
		# git command BRANCH
		if [[ -z "${GSETTING_remote:-}" ]]; then
			export GSETTING_remote="$(git remote | grep -P '^origin\b')"

			if [[ -z "${GSETTING_remote:-}" ]]; then
				out:warn "No remote 'origin' - using first remote. Set GSETTING_remote to override"
				export GSETTING_remote="$(git remote|head -n 1)"
			fi
		fi

		out:info "Using remote '$GSETTING_remote'"
		echo "$GSETTING_remote"
	else
		# git command REMOTE BRANCH
		echo "$1"
	fi
}

function gitn_getBranch {
	out:break "get branch $*"

	if [[ -z "${1:-}" ]]; then
		git branch --list|egrep '^\*'|cut -d' ' -f2
	else
		if [[ -z "${2:-}" ]]; then
			out:break "return 1 $1"
			# git command BRANCH
			echo "$1"
		else
			out:break "return 2 $2"
			# git command REMOTE BRANCH
			echo "$2"
		fi
	fi
}
