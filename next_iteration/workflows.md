# Git Shorthands

New gitn - git shorthands - to be written in python

Distribute as a set of python files, written to /usr/local/lib/* with symlink to main script in /usr/local/bin

To be thought of:

* Can python easily call external binaries?
* Can python produce its own compressed archives?
	* Or should this be a NIX-only option?

## Display branch, check status, diff files, stage files, stage and commit

	gits            # implicit fetchall
	gits -          # explicitly do not fetch all
	gits FILES ...
	gits FILES ... -a
	gits FILES ... -m COMMIT_MESSAGE

Warn when on master, but only prompt to abort when using the commit

## Manage remotes

Command to display remotes, configure a remote, void (delete) a remote, convert to SSH (iff domain is github) or HTTPS

	gits -r
	gits -r NAME URL
	gits -r NAME "-"
	gits -r NAME ["--ssh" [USER]|"--http"]

If current directory is not a git directory, prompt to clone or init

## Manage branches

Command to display branches, or switch to branch (prompt to create) (prompt to re-branch, produce a Give archive), or delete branch

	gits -b
	gits -b BRANCH
	gits -b "-"

Advise to merge after switch

Option to restore archive on inconsistent state

## Push and pull -- default on current branch - default on origin

	gits -s [ [REMOTE] BRANCH ]
	gits -l [ [REMOTE] BRANCH ]

## Merge

Merge "to" other branch, or pull in "from" branch ; produce a Give archive

	gits -u to BRANCH
	gits -u from BRANCH

## Shorthands

Operate on master:

Operating on remote (default origin), Push current branch to remote, Merge current branch to master, if remote exists push master to remote, return to current branch

	gits --pushmaster

Go to top directory of current project, Produce an archive of current state and place in parent folder of project, return to the current WD

	gits --archive
