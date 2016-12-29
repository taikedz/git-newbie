#!/bin/bash

function checkmaster {
	if [[ "$CURBRANCH" = master ]]; then
		warne "\n\tYou are on master"
		if ! (git status|grep 'nothing to commit' -i >/dev/null); then
			warne "\tand there are changes.!\n"
		fi
	fi
}


