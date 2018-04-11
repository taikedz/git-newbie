#%include askuser.sh

function action_commit {
	gitcall add "${GITARGS_files[@]}"

	if [[ "$GSETTING_warnmaster" = true ]] && [[ "$(gitn_getBranch)" = master ]]; then
		askuser:confirm "${CBYEL}WARNING -- you are on master. Continue ?$CDEF" || out:fail "Abort."
		#askuser:confirm "${CBYEL}WARNING -- you are on master. Continue ?$CDEF" || {
		#	askuser:confirm "Would you like to move changes to another branch ?" && {
		#		action_branch_switchto "$(gitn_choose_branch)" || out:fail "Failed to switch"
		#	} || out:fail Abort
		#}
	fi
	
	if [[ -z "${GITARGS_arguments[*]}" ]]; then
		gitcall commit
	else
		gitcall commit -m "${GITARGS_arguments[*]}"
	fi
}
