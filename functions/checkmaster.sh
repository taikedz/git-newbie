#!/bin/bash

function checkmaster {
	if [[ "$CURBRANCH" = master ]]; then
		warne "\n\tYou are on master"
		if ! (git status|grep 'nothing to commit' -i >/dev/null); then
			warne "${CBRED}\tand there are changes. Don't develop on master!\n"
			if uconfirm "Move changes to a different branch?"; then
				switchchangestobranch
			else
				uconfirm "Proceed anyway?" || faile "Aborted." 
			fi
		fi
	fi
}


