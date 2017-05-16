function gitn_last_commit {
	git log | grep ^commit|head -n 1|cut -d' ' -f2
}
