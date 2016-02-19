#!/usr/bin/env bash
#
# Remove git basic configuration files.

##
# This function is used to be able to tell where a script file is and enter its
# directory
#
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "$1" )" && pwd )"
cd "$DIR"

##
# Remove global .gitignore.
##
if [ -h "$HOME/.gitignore" ]; then
  echo "- Removing global .gitignore."
  rm "$HOME/.gitignore"

else
  echo "- Global .gitignore is not currently installed."
fi

##
# Remove -gitconfig file.
##
if [ -f "$HOME/.gitconfig" ]; then
  echo "- Removing gitconfig."
  rm "$HOME/.gitconfig"
else
  echo "- .gitconfig file is not currently installed."
fi
