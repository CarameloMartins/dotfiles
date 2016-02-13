#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Remove $HOME/.bin folder.
#-------------------------------------------------------------------------------

##
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

BIN="$HOME/.bin"

echo "- Removing files that were copied before."

find -type f -name "*.cp" |
while read FILE
do
  FILE=${FILE%.*}
  echo "- Checking $BIN/${FILE##*/}."
  if [ -f "$BIN/${FILE##*/}" ]; then
    echo " - Removing $BIN/${FILE##*/}."
    rm "$BIN/${FILE##*/}"
  else
    echo " - ${FILE##*/} doesn't exist."
  fi
done

if [ -d "$HOME/.bin" ]; then
  echo "- Folder \$HOME/.bin exists. Removing it."
  rmdir "$HOME/.bin"
else
  echo "- Folder \$HOME/.bin doesn't exist."
fi
