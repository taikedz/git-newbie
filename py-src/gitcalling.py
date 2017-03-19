#!/usr/bin/python

import re
from subprocess import call

gitbin = "/usr/bin/git" # TODO make a settings loading section and a settings object

def makeGitCommand(action, arguments):
    if type(arguments) == str:
        arguments = re.split(" +", arguments)
    arguments.insert(0, action)

def callGit(argarray, inputstring):
    if argarray[0] != 'git':
        print("BAD ARG ARRAY" + str(argarray) )
        exit(1)

    subp = call(argarray)
    return subp.communicate(inputstring) # Returns a tuple of stdout and stderr

