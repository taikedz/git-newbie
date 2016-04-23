#!/bin/bash

branchpat='^[a-zA-Z0-9_-]+$'

function switchchangestobranch {
	local dash="$-"; set -e

	gotobranch=$(echo $(uchoose "Which branch should ALL tracked and uncommitted changes be moved to?" "$(git branch|egrep -v '^\* ')"))
	# extra echo wrap to remove trailing whitespaces
	if [[ -z "$gotobranch" ]]; then
		if uconfirm "Nothing selected. Create a new branch?" ; then
			if ! (git branch "$(uask "Name of new branch")" ); then faile "Aborting switch"; fi
		elif ! (uconfirm "Proceed anyway?"); then
			faile "Ran away!"
		fi
	elif [[ ! "$gotobranch" =~ $branchpat ]]; then
		faile "Invalid branch [$gotobranch]"
	fi
	infoe "Creating $CURBRANCH backup"
	tarbranch
	git stash
	git checkout "$gotobranch"
	CURBRANCH="$(git branch|grep -P '(?<=\* ).+' -o)"
	infoe "Creating $CURBRANCH backup" # Sometimes the automerge is catastrophically bad - notably on large changes
	tarbranch
	git stash apply

	if [[ ! $dash =~ e ]]; then set +e; fi
}

function switchbranch {
	local newbranch=$1; shift

	if ! (git branch|grep "$newbranch" >/dev/null); then
		uconfirm "'$newbranch' does not exits. Create it?" && {
			if [[ "$newbranch" =~ $branchpat ]]; then
				git branch "$newbranch"
			else
				faile "Invalid branch name. Branch name can only contain a-z A-Z 0-9, '_' and '-'"
			fi
		}
	fi
	git checkout "$newbranch"
	CURBRANCH="$(git branch|grep -P '(?<=\* ).+' -o)"
	if [[ "$CURBRANCH" = master ]]; then
		warne "Consider doing a merge"
	else
		warne "Consider performing a rebase"
	fi
}
