function displayhelp {

cat <<ENDOFHELP
=========================
     gitn
=========================

VERSION 2016-11-27-HK

Shorthands for managing git repositories, and some guided automation around common pitfalls

---	AUTHOR & LICENSE

(C) 2016 Tai Kedzierski

License: GPLv3 https://www.gnu.org/licenses/gpl-3.0.html

TL;DR : GPL Licensing focuses on the freedom of users, not the freedom of developers and software publishers to restrict and enslave users. Therefore:

* You may run this software for any purpose
* You may redistribute this software to anyone
* You may modify this software and distribute your changes as you see fit
* You must grant the same permissions as this license, or any additional permissions not conflicting with this license, to your users
* You must retain this copyright and license notice
* You may add your name to the copyright list for your version, but must not remove previous authors
* You must deliver the source code of any binary you distribute in human-readable form to anybody who asks
	* Obfuscated/minified code is not considered source code under this license
	* Maintain your copy of the source: if your upstream disappears, you must still be able to provide the source for your version


---	USAGE

gitn will tell you whether you have been working on master and allow you to move current changes to a different branch

gitn

	gitn on its own will perform `git fetch` and `git status`

gitn FILES ...

	gitn stated without actions will display each specified file in turn, and show changes in `less` using coloured output.

gitn FILES ... -a

	This will cause "git add" to be called on the files

	Will warn of operating on master.

gitn { FILES ... | "." } -m [MESSAGE ...]

	Commit all staged files with MESSAGE.

	If FILES are specified, adds them.

	If "." is specified instead of a list of files, adds all unstaged changes, and commits them with the message.

	Will warn of operating on master, and offer to move files to a different branch before proceeding.

gitn [-l|--pull]

	Pull remote data from origin.

gitn [-s|--push]

	Push current commit state to origin.

gitn {-b|--branch} BRANCH

	Switch to specified branch. If BRANCH does not yet exist, you are prompted to create it.

gitn {-r|--rebranch} BRANCH

	Move current tracked and unstaged changes to a different branch BRANCH. Does not affect currently untracked files.

gitn {-u|--merge} BRANCH

	Merge BRANCH into the current branch (produces a TAR of the current state before perfomring the merge).

gitn --pushmaster

	Push committed changes in current branch to master, and push both to origin.

gitn --givemaster [OUTFILE]

	Produce a .tar.gz file of the master branch of this project, without the .git tracking directory.

ENDOFHELP
}

