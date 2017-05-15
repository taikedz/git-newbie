function args_processargs {
	# Get tokens until we encounter an option or '//'
	if [[ -n "${GITARGS_action:-}" ]]; then
		return
	fi

	local action_default=status

	local l_GITARGS_files=
	GITARGS_action="$action_default"
	local l_GITARGS_arguments=

	for token in "$@"; do
		if [[ "${token:0:1}" = '-' ]]; then
			GITARGS_action="$(args_getActionFor "$token")"

		elif [[ "$token" = '//' ]]; then
			GITARGS_action=commit

		else
			if [[ "$GITARGS_action" = "$action_default" ]]; then
				GITARGS_files[${#GITARGS_files[@]}]="$token"
				GITARGS_action=diff
			else
				GITARGS_arguments[${#GITARGS_arguments[@]}]="$token"
			fi
		fi

	done

	GITARGS_files="${l_GITARGS_files[@]:1}"
	GITARGS_arguments="${l_GITARGS_arguments[@]:1}"
}

function args_getActionFor {
	case "$1" in
		-u)
			# merge to
			echo "update" ;;
		-m)
			# merge from
			echo "merge" ;;
		-l)
			echo "pull" ;;
		-s)
			echo "push" ;;
		-b)
			echo "branch" ;;
		-t)
			echo "remote" ;;
		--debug)
			echo "$GITARGS_action" ;;
	esac
}
