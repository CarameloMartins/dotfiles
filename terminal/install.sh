#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Install script for Terminal settings.
#-------------------------------------------------------------------------------

##
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

find -type f -name "*.lnk" |
while read FILE
do
  FILE=${FILE%.*} # Set correct file name!
  if [ ! -h "$HOME/.${FILE##*/}" ]; then
    echo "- Installing $HOME/.${FILE##*/}!"
    ln -s "$DIR/${FILE##*/}.lnk" "$HOME/.${FILE##*/}"
  else
    echo "- $HOME/.${FILE##*/} already exists!"
  fi
done
