### Tags Usage:api
# Add git tags
###/doc

function dotags {
	tagname="$(uask "What tag would you like to apply ?")"

	git tag "$tagname"
}
