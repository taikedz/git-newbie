# git-newbie - a helpful git wrapper

`gitn` is a helpful wrapper for working with git.

It acts as a single, easy-to-use command for new users of git to get the most out of the basics, and acts as a molly-guard against some bad newbie development practices.

## Installing

	git clone https://github.com/taikedz/git-newbie
	cd git-newbie
	./install # or, sudo ./install

After this, the `gitn` command is installed and ready to use for any new terminal.

## `master` warnings

It is generally bad practise to develop and commit on the master branch - git is very much geared towards making branching and mergin easy.

If you do not want to be warned when developing on master, use the setting `GSETTING_master=false`

## Useful features

Running `gitn` without arguments will cause a `git fetch` to happen (unless you specify argument `--nf`, or use setting `GSETTING_nofetch=true`) and then display the `git status` - for example

	gitn

Running `gitn` simply with a list of changed files will bring up a colorized `git diff` in `less`, once for each, allowing you to easily view and navigate the changes before committing.

Example:

	gitn fileA fileB

You can then easily commit in one step:

	gitn fileA fileB -m "Commit message"

## Building `gitn`

I am using my [`bash-builder`](https://github.com/taikedz/bash-builder) to maintain `gitn`.
