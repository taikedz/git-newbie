function gitn_choose_branch {
	uchoose "Which branch" "$(git branch --list 2>&1|sed -r 's/^..//')"
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
	if [[ -z "${2:-}" ]]; then
		# git command BRANCH
		if [[ -n "${GSETTING_remote:-}" ]]; then
			echo "$GSETTING_remote"
		else
			warne Implicitly returning first remote
			git remote -v|cut -f1|sort|uniq|head -n 1
		fi
	else
		# git command REMOTE BRANCH
		echo "$1"
	fi
}

function gitn_getBranch {
	if [[ -z "${1:-}" ]]; then
		git branch --list|egrep '^\*'|cut -d' ' -f2
	else
		if [[ "${2:-}" ]]; then
			# git command BRANCH
			echo "$1"
		else
			# git command REMOTE BRANCH
			echo "$2"
		fi
	fi
}
