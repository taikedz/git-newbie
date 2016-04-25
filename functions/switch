#!/bin/bash

TARGETUSER=

function getuser {
	while [[ -n "$*" ]]; do
		ARG="$1"; shift
		case "$ARG" in
			--to)
				TARGETUSER=$1; shift
				return
				;;
		esac
	done
}

# call `switchtossh ./ username` to just switch the current dir
function switchtossh {
	getuser "$@"
	if [[ -z "$TARGETUSER" ]]; then echo "specify target user with '--to USER'"; return 1; fi

	for mydir in "$@"; do
	[[ -d "$mydir/.git" ]] && (
		cd "$mydir"
		origin=$(git remote -v|grep fetch|cut -f1)
		url=$(git remote -v|grep fetch|cut -f2|cut -f1 -d' '|grep -E -o 'github.com.+')

		if [[ "$url" =~ /$TARGETUSER/ ]]; then
			if [[ "$*" =~ --dry-run ]]; then
				echo "$origin $(git remote -v|grep fetch|cut -f2) -> ssh://$TARGETUSER@$url"
			else
				echo "(cd '$mydir'; git remote set-url $origin 'ssh://$TARGETUSER@$url')"
			fi
		else
			[[ "$*" =~ --dry-run ]] && echo "... skipped $(basename $PWD)"
		fi
	)
	done
}
