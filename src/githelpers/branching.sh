function gitn_getBranch {
	gitcall branch --list
}

function gitn_getRemote {
	gitcall remote -v
}
