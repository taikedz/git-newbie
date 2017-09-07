#!/bin/bash

if [[ ! -d unit-tests ]] || (ls unit-tests|grep -q "test.sh"); then
	echo "No unit tests"
	exit 1
fi

exitcode=0

for unittest in unit-tests/*-test.sh; do

	echo "Running $unittest"
	
	bash "$unittest"
	exitcode=$((exitcode + $?))

done

exit "$exitcode"
