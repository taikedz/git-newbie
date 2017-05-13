function action_diff {
	for thefile in "${GITARGS_files[@]}"; do
		gitcall diff "$thefile" | sed -r -e 's/^\+(.*)$/[32;1m\1[0m/' -e 's/^-(.*)$/[31;1m\1[0m/'|less -R
	done
}
