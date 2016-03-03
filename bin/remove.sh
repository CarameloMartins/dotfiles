#!/usr/bin/env bash
#
# Remove $HOME/.bin folder and its contents.

##
# This function is used to be able to tell where a script file is and enter its
# directory
#
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

BIN="$HOME/.bin"

# Remove files in ~/-bin folder.
while IFS= read -r FILE
do
  FILE=${FILE%.*}
  echo "- Checking $BIN/${FILE##*/}."
  if [ -f "$BIN/${FILE##*/}" ]; then
    echo " - Removing $BIN/${FILE##*/}."
    rm "$BIN/${FILE##*/}"
  else
    echo " - ${FILE##*/} doesn't exist."
  fi
done < <(find -type f -name "*.copy")

# Remove ~/.bin folder.
if [ -d "$HOME/.bin" ]; then
  echo "- Folder \$HOME/.bin exists. Removing it."
  rmdir "$HOME/.bin"
else
  echo "- Folder \$HOME/.bin doesn't exist."
fi
