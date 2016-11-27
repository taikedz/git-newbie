#!/bin/bash

# ..... MESSY....!

while [[ -n "$@" ]]; do
	ARG=$1
	shift

	case "$ARG" in
	--debug)
		MODE_DEBUG=yes
		;;
	-c|--clone)
		git clone "$@"
		exit $?
		;;
	-t|--remote)
		git remote -v
		exit $?
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
		origin=origin
		if [[ -n "$*" ]]; then
			origin=$1
		fi
		infoe "git push $origin $CURBRANCH"
		git push $origin "$CURBRANCH"
		exit $?
		;;
	-l|--pull)
		origin=origin
		if [[ -n "$*" ]]; then
			origin=$1
		fi
		infoe "git pull $origin $CURBRANCH"
		git pull $origin "$CURBRANCH"
		exit $?
		;;
	-g|--log)
		git log
		exit $?
		;;
	-u|--merge)
		if [[ -z "$*" ]]; then faile "Specify a branch to merge from"; fi
		tarbranch
		infoe "merging [$1] into [$CURBRANCH]"
		git merge "$1"
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
			givemaster # auto temp file
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
