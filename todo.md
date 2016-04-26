# Things that need doing

Some of these items shouuld be in help, others can be part of the automation.

Need to be able to preempt when switching to a new branch will cause auto-merge. Problem is, automerge can be crap when dealing with extensive changes so is not necesarily desirable.

One way is to systematically `git stash branch <autogen-name>` to create a new branch and apply the stash there, and provide instructions on how to go to other branch and rebase of this stash

* other common operations
	* rename files
	* delete files
	* support unstaging
	* delete branches
* rename branches
* supprt blames and resets
* display "branch -a" and "branch --merged" when on master (or can we only display branches coming off of current branch?)
* support log reading in less
* add byte formatting to documentation
	* underscore
	* bold
* git ssh setup assistance

See some extra tips:

* [git tips and tricks](http://geant.cern.ch/content/git-tips-and-tricks)
* [19 git tips for everyday use](http://www.alexkras.com/19-git-tips-for-everyday-use/)

## How to rename a branch locally and remotely

[Benjamin Haas](http://www.benjaminlhaas.com/blog/locally-and-remotely-renaming-branch-git)

First, you want to change your local branch. This couldn't be easier:

	git branch -m my-hot-feature feature-15

Then, you want to change the remote branch. This is a bit more complex, because you can't directly rename the remote branch. Instead you have to delete the remote branch with the old name, and recreate it with the new name. You need to start by getting the remote name:

	git remote -v

This should give you something like this:

	origin https://github.com/benjaminlhaas/Yii-with-Users-and-Rights (fetch)
	origin https://github.com/benjaminlhaas/Yii-with-Users-and-Rights (push)

The remote name here is "origin." So now that you know this, you can delete and re-create the remote branches.

Delete the remote branch with the old name:

	git push origin :my-hot-feature

Re-create the remote branch with the new name:

	git push origin feature-15

## Pull lots

If you are in a directory mydir/ containing git repositories `mydir/a`, `mydir/b`, `mydir/c` -- you can run the following to checkup on each repo's state

Somehow this could be integrated in some sort of "extra tools" app, along with SSH renaming?

	for x in colours bashout askuser; do source "$BBPATH/$x.source"; done
	for x in ./*; do
		[[ -d "$x/.git" ]] && (
			echo "$x"
			cd "$x"
			(git remote -v|grep 'github.com' -q) || exit
			
			gitn &&
				uconfirm "Pull?" &&
				gitn -l &&
				git status &&
				uconfirm "Push?" &&
				gitn -s
		)
	done
