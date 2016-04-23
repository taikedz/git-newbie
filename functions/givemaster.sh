#!/bin/bash

function givemaster {
	givebranch master
}

function givebranch {
	local tbranch=$1; shift
	local oldbranch=$CURBRANCH

	switchbranch $tbranch
	local tgtdir=$(myprojdir)
	if [[ ${1+x} = x ]]; then
		local mytmp=$1
	else
		local mytmp="$(mktemp --tmpdir "$tbranch-$(basename "$tgtdir")-XXX.tgz")"
	fi
	tarnow "$mytmp" "$tgtdir"
	switchbranch "$oldbranch"
	infoe "Wrote branch [$tbranch] contents to $mytmp"
}

function tarbranch {
	local tgtdir=$(myprojdir)
	local mytmp="$(mktemp --tmpdir "$CURBRANCH-$(basename "$tgtdir")-XXX.tgz")"
	tarnow "$mytmp" "$tgtdir"
	infoe "Wrote branch [$CURBRANCH] contents to $mytmp"
}

function tarnow {
	tar -czf "$1" -C "$2" ./ --exclude='./.git*'
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
