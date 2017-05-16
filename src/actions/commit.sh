#%include askuser.sh

function action_commit {
	gitcall add "${GITARGS_files[@]}"

	if [[ "$GSETTING_warnmaster" = true ]] && [[ "$(gitn_getBranch)" = master ]]; then
		uconfirm "WARNING -- you are on master. Continue ?" || faile Abort
	fi
	
	if [[ -z "${GITARGS_arguments[*]}" ]]; then
		gitcall commit
	else
		gitcall commit -m "${GITARGS_arguments[*]}"
	fi
}
