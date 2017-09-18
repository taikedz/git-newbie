# git-newbie - a helpful git wrapper

`gitn` is a helpful wrapper for working with git.

It acts as a single, easy-to-use command for new users of git to get the most out of the basics, and acts as a molly-guard against some bad newbie development practices.

## Installing

	git clone https://github.com/taikedz/git-newbie
	cd git-newbie
	./install.sh

	# or, optionally, `sudo ./install.sh`, to install for everybody


After this, the `gitn` command is installed and ready to use for any new terminal.

## `master` warnings

It is generally bad practise to develop and commit on the master branch - git is very much geared towards making branching and mergin easy.

If you do not want to be warned when developing on master, use the setting `GSETTING_master=false`

## Useful features

### Shorthand fetch + status

Run `gitn` without arguments to see the status. This will also do a `git fetch` first, disable this with the `--nf` option

	gitn [--nf]

### Use command history to provide a commit message

Running `gitn` simply with a list of changed files will bring up a colorized `git diff` in `less`, once for each, allowing you to easily view and navigate the changes before committing.

Example:

	gitn fileA fileB

You can then easily commit in one step:

	gitn fileA fileB -m Your commit message here

### Move your changes

Switch branches with changes still pending: if you have uncommitted changes, these will move over to the target branch when you switch.

You will be prompted for this should the situation occur.

### See files in log

`gitn -log` shows the git log, whilst also displaying the files that were changed and added with that commit.

	gitn -log

## Building `gitn`

This project uses [`bash-builder`](https://github.com/taikedz/bash-builder) to maintain `gitn`.

To build the project, simply run

	bbuild


