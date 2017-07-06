# Add a license to the project

GSETTING_licenses=/var/gitn/licsupport

function action_license {
	# GITARGS_* -- files, arguments
	
	case "${GITARGS_arguments[0]}" in
	list)
		ls "$GSETTING_licenses" ;;
	newfile)
		action_license_newfile "${GITARGS_arguments[@]:1}" ;;
	*)
		action_license_setlicense "${GITARGS_arguments[1]}"
		;;
	esac
}

function action_license_newfile {
	local licensename="$1"; shift
	local filename="$1"; shift

	if [[ -z "$licensename" ]]; then
		faile "No license specified"
	fi

	action_license_check "$licensename/head.txt" || faile "$licensename has no header data. Try 'gitn -license list'"

	local codefile="$(action_license_getcodefile "$filename")"
	if [[ -z "$codefile" ]]; then faile "No comment profile found."; fi

	readkv start "$codefile" >> "$filename"

	local midcom="$(readkv mid "$codefile")"
	cat "$GSETTING_licenses/$licensename/head.txt" | sed -r "s|^|$midcom|" >> "$filename"

	readkv end "$codefile" >> "$filename"
}

function action_license_getcodefile {
	local fext="${1##*.}"
	if [[ -z "$fext" ]]; then faile "Could not get extension of $1" ; fi

	local mapfile="$GSETTING_licenses/comments/mapping.conf"
	if [[ -f "$mapfile" ]]; then faile "Could not read mappping file"; fi

	local commentstyle="$(readkv "$fext" "$mapfile")"
	if [[ -z "$commentstyle" ]]; then faile "Could not determine comment style for $fext"; fi

	local commentfile="$GSETTING_licenses/comments/$commentstyle.cmt"
	if [[ ! -f "$commentstyle" ]]; then faile "No profile for $commentstyle"; fi

	echo "$commentstyle"
}

function action_license_setlicense {
	local licensename="$1"; shift

	action_license_check "$licensename/full.txt" || faile "No data for $licensename. Try 'gitn -license list'"

	cp "$GSETTING_licenses/$licensename/full.txt" LICENSE.txt
}

function action_license_check {
	local licensename="$1"; shift

	[[ ! -f "$GSETTING_licenses/$licensename" ]] 
}
