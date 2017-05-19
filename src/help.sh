### Git Newbie Usage:help
#
# The `gitn` tool offers git users shortcuts for some of the most common
# operations, as well as some additional features.
#
# USAGE
# -----
#
#	gitn FILES ... [--historic]
#
# Show the diff of files that have not yet been staged for commit,
#  or show the last changes to the file
#
# ++
#
#	gitn FILES ... -m [COMMIT MESSAGE]
#
# Add and commit the files with the specified commit message
#
# ++
#
# 	gitn -s [ [REMOTE] BRANCH] [--tags]
#
# Push to the specified or inferred branch and remote. If no remote is
#  specified, then the first remote in `git remote -v` is used, or the
#  one in $GSETTING_remote if set. See SETTINGS.
#
#  If --tags is specified, will push tags instead of commits
#
# ++
#
# 	gitn -l [ [REMOTE] BRANCH ]
#
# Pull from specified or inferred branch and remote. If no remote is
#  specified, then the first remote in `git remote -v` is used, or the
#  one in $GSETTING_remote if set. See SETTINGS.
#
# ++
#
# 	gitn -b [BRANCH] [--delete [--force] ]
#
# List branches or switch to specified branch.
#
# If --delete is specified, deletes the branch. Use --force to force the
#  deletion of a branch not fully merged to its upstream.
#
# ++
#
# 	gitn -c OBJECT
#
# Checkout an object
#
# ++
#
# 	gitn -update BRANCH
#
# Write the current commit state to the named branch. If the branch does
#  not exist, it is created.
#
# ++
#
# 	gitn -merge BRANCH
#
# Pulls the changes from the named branch to the current branch.
#
# ++
#
# 	gitn -tags [TAGNAME [MESSAGE ...]]
#
# Create a new tag, optionally with a message
#
# ++
# 
# 	git -t [REMOTE [URLPAT]]
#
# List remotes, list URLs of a specified remote, or set the
#  URL of a remote.
#
# If URLPAT starts with 's/' then it is treated as a sed substitution
#  pattern for re-writing the URL
#
# ++
#
# 	gitn -blame FILES ...
#
# See git blame for each file
#
###/doc

### SETTINGS Usage:help
#
# A settings file `./.gitn` can be used to pre-populate settings
#
# GSETTING_warnmaster
# 	default: true
# 	Displays a warning when committing on master
#
# GSETTING_remote
# 	default: (not set)
# 	The default remote to use when none is specified
#
# GSETTING_nofetch
# 	defaut: false
# 	By default, `gitn` will try to fetch info from remote
#
###/doc
