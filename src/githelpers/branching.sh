function gitn_choose_branch {
	uchoose "Which branch" "$(git branch --list 2>&1|sed -r 's/^..//')"
}

function gitn_getRemote {
	if [[ -z "${1:-}" ]]; then
		if [[ -n "${GSETTING_remote:-}" ]]; then
			echo "$GSETTING_remote"
		else
			warne Implicitly returning first remote
			git remote -v|cut -f1|sort|uniq|head -n 1
		fi
	else
		echo "$1"
	fi
}

function gitn_getBranch {
	if [[ -z "${2:-}" ]]; then
		git branch --list|egrep '^\*'|cut -d' ' -f2
	else
		echo "$2"
	fi
}
