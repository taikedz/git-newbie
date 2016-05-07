# git-newbie - a helpful git wrapper

`gitn` is a helpful wrapper for working with git.

It acts as a single, easy-to-use command for new users of git to get the most out of the basics, and acts as a molly-guard against some bad newbie development practices.

## Installing

	git clone https://github.com/taikedz/git-newbie
	cd git-newbie
	sudo ./release/git-newbie-1.0.1.tgz.sh # self-extracting installer

After this, the `gitn` command is installed and ready to use.

## `master` warnings

Notably, it will warn you every time you are on master.

If you have made changes, it will also offer to help you move these to a different branch.

This also kicks in prior to staging and committing.

Don't develop on master!

### Pre-merge backups

The facility to move changes from one branch to another uses a `git stash ; git checkout BRANCH ; git stash apply`

When large amounts of changes have been performed, the auto-merge on `git stash apply` tends to be atrocious - it was not meant for larges swathes of changes. `gitn` mitigates disastrous stash application by creating a tar backup both of the original branch and the destination branch prior to applying the stash, shuold the files get mangled.

The `gitn --merge` task also benefits from this: when performing the merge, gitn will fist create a `.tar.gz` archive in the temp folder, before performing the merge.

## Useful features

Running `gitn` without arguments will cause a `git fetch` to happen (unless you specify argument `-nf`) and then display the `git status` - for example

	gitn

Running `gitn` simply with a list of changed files will bring up a colorized `git diff` in `less`, once for each, allowing you to easily view and navigate the changes before committing.

Example:

	gitn fileA fileB

You can then add

	gitn fileA fileB -a

and even commit

	gitn fileA fileB -m "Commit message"

### branch switch recommendations

For now, `gitn` simply displays a recommendation based on whether you are on master or not, but analyzing the state of merges would be nice.

## Building `gitn`

I am using my [`bash-builder`](https://github.com/taikedz/bash-builder) to maintain `gitn`. At some point I'll split out sub-functionality, but still be able to ship single executables.
