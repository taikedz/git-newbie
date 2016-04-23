#!/bin/bash

# need to also consider - merge and rollback

while [[ -n "$@" ]]; do
	ARG=$1
	shift

	case "$ARG" in
	--debug)
		MODE_DEBUG=yes
		;;
	-b|--branch)
		switchbranch "$1"; shift
		;;
	-r|--rebranch)
		switchchangestobranch "$1"; shift
		;;
	-m)
		ACTION=commit
		COMMIT="$*" # get the rest of the arguments as commit message
		break
		;;
	-a)
		ACTION=add
		;;
	-nf)
		FETCHING=no
		;;
	-s|--push)
		infoe "git push origin $CURBRANCH"
		git push origin "$CURBRANCH"
		exit $?
		;;
	-l|--pull)
		infoe "git pull origin $CURBRANCH"
		git pull origin "$CURBRANCH"
		exit $?
		;;
	-u|--rebase)
		if [[ -z "$*" ]]; then faile "Specify a branch to rebase from"; fi
		infoe "rebasing [$CURBRANCH] to [$1]"
		git rebase "$1"
		exit $?
		;;
	--pushmaster)
		pushmaster
		exit $?
		;;
	--givemaster)
		if [[ -n "$*" ]]; then
			givemaster "$1"
		else
			givemaster
		fi
		exit $?
		;;
	*)
		if [[ -e "$ARG" ]]; then
			ADDFILE="$ADDFILE $ARG"
		else
			faile "No such file [$ARG]" 2
		fi
		;;
	esac
done
