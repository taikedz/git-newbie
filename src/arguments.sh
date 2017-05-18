function args_processargs {
	# This section is unfortunately ugly
	#
	# anything that can be done to clean up?
	
	if [[ -n "${GITARGS_action:-}" ]]; then
		return
	fi

	local action_default=status

	local l_GITARGS_files
	GITARGS_action="$action_default"
	local l_GITARGS_arguments

	for token in "$@"; do
		if [[ "${token:0:1}" = '-' ]]; then
			if [[ "${token:1:1}" = '-' ]]; then
				arguments_dosetting "$token"
			else
				GITARGS_action="$(args_getActionFor "$token")"
			fi

		else
			if [[ "$GITARGS_action" = "$action_default" ]] ||
			   [[ "$GITARGS_action" = diff ]]; then
				l_GITARGS_files[${#l_GITARGS_files[@]}]="$token"
				GITARGS_action=diff

			else
				l_GITARGS_arguments[${#l_GITARGS_arguments[@]}]="$token"
			fi
		fi

	done

	GITARGS_files=("${l_GITARGS_files[@]}")
	GITARGS_arguments=("${l_GITARGS_arguments[@]}")
}

function arguments_dosetting {
	case "$1" in
	--tags)
		export GSETTING_withtags=true ;;

	--no-fetch|--nf)
		export GSETTING_nofetch=true ;;

	--historic)
		export GSETTING_histdiff=true ;;

	--delete)
		export GSETTING_delbranch=true ;;

	--force)
		export GSETTING_force=true ;;

	--no-warn-master)
		export GSETTING_warnmaster=false ;;

	--debug)
		: ;;
	*)
		faile "Unknown setting '$1'" ;;
	esac
}

function args_getActionFor {
	case "$1" in
		-update)
			# merge to
			echo "update" ;;

		-merge)
			# merge from
			echo "merge" ;;

		-m|-commit)
			echo "commit" ;;

		-l|-pull)
			echo "pull" ;;

		-s|-push)
			echo "push" ;;

		-b|-branch)
			echo "branch" ;;

		-c|-checkout)
			echo "checkout" ;;

		-g|-log)
			echo "log" ;;

		-r|-remote)
			echo "remote" ;;

		-stash)
			echo "stash" ;;

		-tags)
			echo "tag" ;;

		-release)
			echo "release" ;;

		*)
			faile "Action $1 unknown"
			;;
	esac
}
