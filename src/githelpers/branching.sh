
function gitn_getRemote {
	if [[ -z "${1:-}" ]]; then
		warne Implicitly returning first remote
		gitcall remote -v|cut -f1|sort|uniq|head -n 1
	else
		echo "$1"
	fi
}

function gitn_getBranch {
	if [[ -z "${2:-}" ]]; then
		gitcall branch --list|egrep '^\*'|cut -d' ' -f2
	else
		echo "$2"
	fi
}
