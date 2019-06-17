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

from git import exc, Repo

def iterate_folders(path):
    if os.path.isdir(path):
        dirs = os.listdir(path)


        try:
            repo = Repo(path)
            branches = repo.branches

            print("\033[36m" + path + ":\033[0m")
            print("- {} branches.".format(len(branches)))

            if repo.is_dirty():
                print("\033[91m[WARN] Repo is dirty, not risking a pull!!\033[0m")
            else:
                for branch in branches:
                    print("- Pulling \033[33m'{}'\033[0m branch.".format(branch.name))
                    try:
                        repo.git.checkout(branch.name)
                        repo.git.pull()
                    except Exception as ex:
                        print("[Error] ", ex)

        except exc.InvalidGitRepositoryError:
            if os.path.isdir(path):
                try:
                    dirs = os.listdir(path)

                    for dir in dirs:
                        realpath = os.path.realpath(path + "/" + dir)
                        iterate_folders(realpath)
                except exc.InvalidGitRepositoryError:
                    print("\033[91m[WARN] This doesn't seem to be a valid repository.\033[0m")
        

##
# Parse arguments.
##
if len(sys.argv) < 2:
    raise Exception('Please provide a path to act on.')

path = os.path.realpath(sys.argv[1])

print("Searching " + path + ".")

##
# Iterate each folder.
##

iterate_folders(path)


print("Finished searching.")
