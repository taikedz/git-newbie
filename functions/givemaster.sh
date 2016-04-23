#!/bin/bash

function givemaster {
	givebranch master
}

function givebranch {
	local tbranch=$1; shift
	local oldbranch=$CURBRANCH

	switchbranch $tbranch
	if [[ ${1+x} = x ]]; then local mytmp=$1
	local tgtdir=$(myprojdir)
	else local mytmp="$(mktemp --tmpdir "$tbranch-$(basename "$tgtdir")-XXX.tgz")"; fi
	tar -czf "$mytmp" -C "$tgtdir" ./ --exclude='./.git*'
	switchbranch "$oldbranch"
	infoe "Wrote branch [$tbranch] contents to $mytmp"
}

function myprojdir {
(
	while [[ ! -d ./.git ]]; do
		if [[ "$PWD" = / ]]; then
			exit 1
		fi
		cd ..
	done
	echo "$PWD"
) || faile "Not a git directory"
}
