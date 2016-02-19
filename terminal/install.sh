#!/usr/bin/env bash
#
# Install script for Terminal settings.

##
# This function is used to be able to tell where a script file is and enter its
# directory
#
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "$1" )" && pwd )"
cd "$DIR"

while IFS= read -r FILE
do
  FILE=${FILE%.*} # Set correct file name!
  if [ ! -h "$HOME/.${FILE##*/}" ]; then
    echo "- Installing $HOME/.${FILE##*/}."
    ln -s "$DIR/${FILE##*/}.symlink" "$HOME/.${FILE##*/}"
  else
    echo "- $HOME/.${FILE##*/} already exists."
  fi
done < <(find -type f -name "*.symlink")
