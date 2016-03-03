#!/usr/bin/env bash
#
# Install ~/.bin and its contents.

##
# This function is used to be able to tell where a script file is and enter its
# directory
#
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

# Install ~/.bin if none exists.
if [ ! -d "$HOME/.bin" ]; then
  echo "- Folder \$HOME/.bin doesn't exist. Creating it."
  mkdir "$HOME/.bin"
else
  echo "- Folder \$HOME/.bin already exists."
fi

BIN="$HOME/.bin"

# Copy custom scripts to ~/.bin.
while IFS= read -r FILE
do
  FILE=${FILE%.*}
  echo "- Checking $BIN/${FILE##*/}."
  if [ ! -f "$BIN/${FILE##*/}" ]; then
    echo " - Installing $BIN/${FILE##*/}."
    cp "$DIR/${FILE##*/}.copy" "$BIN/${FILE##*/}"
    chmod +x "$BIN/${FILE##*/}"
  else
    echo " - ${FILE##*/} already exists."
  fi
done <  <(find -type f -name "*.copy")
