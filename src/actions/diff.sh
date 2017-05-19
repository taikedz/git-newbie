function action_diff {
	for thefile in "${GITARGS_files[@]}"; do
		if [[ "$GSETTING_histdiff" = true ]]; then
			action_diff_historic "$thefile"
		else
			action_diff_staged "$thefile"
		fi
	done
}

function action_diff_historic {
	gitcall log -p "$1"
}

function action_diff_staged {
	gitcall diff "$1" | action_diff_display
}

function action_diff_display {
	sed -r -e 's/^\+(.*)$/[32;1m+\1[0m/' -e 's/^-(.*)$/[31;1m-\1[0m/'|less -R
}
