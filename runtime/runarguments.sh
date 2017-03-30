#!/bin/bash

# ..... MESSY....!

while [[ -n "$@" ]]; do
	ARG=$1
	shift

	case "$ARG" in
	--debug)
		MODE_DEBUG=yes
		;;
	-gh|--github)
		if ! { which curl >/dev/null ; }; then
			faile "Cannot find curl -- abort"
		fi
		if [[ -n "$*" ]]; then
			NEWREPO="$1" ; shift
			DESC="$*"
			uname=$(uask "username")
			curl -u "$uname" "https://api.github.com/user/repos" -d "{\"name\":\"$NEWREPO\", \"description\":\"$DESC\" }"
		else
			faile "No repository specified"
		fi
		exit $?
		;;
	-t|--remote)
		if [[ -n "$*" ]]; then
			newremote="$1"; shift
			if [[ -n "$*" ]]; then
				rurl="$1"; shift
			else
				git remote -v | grep "$newremote"
			fi
			if { git remote | grep "$newremote" -q ;}; then
				git remote set-url "$newremote" "$rurl"
			else
				git remote add "$newremote" "$rurl"
			fi
		else
			git remote -v
		fi
		exit $?
		;;
	-b|--branch)
		if [[ -n "$1" ]]; then
			switchbranch "$1"; shift
		else
			listbranches
		fi
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
		if [[ -z "$*" ]]; then
			git log
		else
			for thefile in "$@"; do
				if [[ -f "$thefile" ]]; then
					git log -p "$thefile"| sed -r -e 's//^[/g' -e "s/^(-.*)$/${CRED}\1${CDEF}/" -e "s/^(\+.*)$/${CGRN}\1${CDEF}/" -e "s/^(@@.+)$/${CBLU}\1${CDEF}/" -e "s/^(commit.+)$/${CBYEL}\1${CDEF}/" |less -R

				elif [[ "$thefile" =~ $(echo "^--") ]]; then
					# Ignore would-be options
					continue

				else
					warne "Not a file [$thefile]"
				fi
			done
		fi
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
