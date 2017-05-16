### gitcall Usage:gitn-api
#
# Call git, and printout what we're actually doing
#
###/doc
function gitcall {
	breake "git $@"
	git "$@"
}
