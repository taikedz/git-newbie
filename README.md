# git-newbie - a helpful git wrapper

`gitn` is a helpful wrapper for working with git.

It started out as a simple shortcut for adding and committing at the same time without having to re-write commands between diffs and commit instructions, but recently has grown to be a minor molly-guard to some bad beginners' habits.

## `master` warnings

Notably, it will warn you every time you are on master.

If you have made changes, it will also offer to help you move these to a different branch.

This also kicks in prior to staging and committing.

Don't develop on master!

### Pre-automerge backups

The facility to move changes from one branch to another uses a `git stash ; git checkout BRANCH ; git stash apply`

When large amounts of changes have been performed, the auto-merge on `git stash apply` tends to be atrocious - it was not meant for larges swathes of changes. `gitn` mitigates disastrous stash application by creating a tar backup both of the original branch and the destination branch prior to applying the stash, shuold the files get mangled.

On the to-do list is adding similar safeguards around merging, pulling, rebasing, etc.

## Installing

Run `sudo ./bbmake --install` to install the latest version

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
