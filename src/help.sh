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
#	gitn FILES ... // [COMMIT MESSAGE]
#
# Add and commit the files with the specified commit message
#
# ++
#
# 	gitn -s [REMOTE [BRANCH]] [--with-tags]
#
# Push to the specified remote. If no remote is specified, then the first
#  remote in `git remote -v` is used, or the one in $GSETTING_remote if
#  set. See SETTINGS.
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
