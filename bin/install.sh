#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Install bin/ in $HOME with as .bin.
#-------------------------------------------------------------------------------

##
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

if [ ! -d "$HOME/.bin" ]; then
  echo "- Folder \$HOME/.bin doesn't exist. Creating it."
  mkdir "$HOME/.bin"
else
  echo "- Folder \$HOME/.bin exists already."
fi

BIN="$HOME/.bin"

echo "- Copying files that don't exist."

find -type f -name "*.cp" |
while read FILE
do
  FILE=${FILE%.*}
  echo "- Checking $BIN/${FILE##*/}."
  if [ ! -f "$BIN/${FILE##*/}" ]; then
    echo " - Installing $BIN/${FILE##*/}."
    cp "$DIR/${FILE##*/}.cp" "$BIN/${FILE##*/}"
    chmod +x "$BIN/${FILE##*/}"
  else
    echo " - ${FILE##*/} already exists."
  fi
done
