#!/bin/bash

bins="$HOME/.local/bin/"
if [[ "$UID" = 0 ]]; then
	bins=/usr/local/bin
fi

cp bin/gitn "$bins"
