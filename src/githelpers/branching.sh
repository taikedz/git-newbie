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
	breake "get remote $*"

	if [[ -z "${2:-}" ]]; then
		# git command BRANCH
		if [[ -z "${GSETTING_remote:-}" ]]; then
			warne Implicitly returning first remote
			export GSETTING_remote="$(git remote -v|cut -f1|sort|uniq|head -n 1)"
		fi

		echo "$GSETTING_remote"
	else
		# git command REMOTE BRANCH
		echo "$1"
	fi
}

function gitn_getBranch {
	breake "get branch $*"

	if [[ -z "${1:-}" ]]; then
		git branch --list|egrep '^\*'|cut -d' ' -f2
	else
		if [[ -z "${2:-}" ]]; then
			breake "return 1 $1"
			# git command BRANCH
			echo "$1"
		else
			breake "return 2 $2"
			# git command REMOTE BRANCH
			echo "$2"
		fi
	fi
}
