#!/usr/bin/env python
#
# pall.py
#
# Executes a `git pull` over all the subfolders in a given folder, and on the folder
# itself.
#

import os
import sys
import subprocess

##
# Parse arguments.
##
if len(sys.argv) < 2:
    raise Exception('Please provide a path to act on.')

path = os.path.realpath(sys.argv[1])
dirs = os.listdir(path)

print("Searching " + path + ".")

##
# Iterate each folder.
##
for dir in dirs:
    realpath = os.path.realpath(path + "/" + dir)
    print(dir + ":")
    os.chdir(realpath)

    if os.path.exists(".git/"):
        output = subprocess.check_output(["git", "pull"])
        print(output)
    else:
        print("NO git repo.")

print("Finished searching.")
