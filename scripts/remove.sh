#!/usr/bin/env bash
#
# Run all remove.sh scripts.

##
# This function is used to be able to tell where a script file is and enter its
# directory
#
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

DOTFILES=${DIR%/*}

##
# Remove git configurations.
##
echo "- Removing git configurations."

if [ -f "$HOME/.gitconfig" ]; then
  echo "  - Removing gitconfig."
  rm "$HOME/.gitconfig"
else
  echo "  - .gitconfig file is not currently installed."
fi

##
# Remove files installed with `symlink` extension from $HOME folder.
##
echo "- Removing linked files."

while IFS= read -r FILE
do
  FILE=${FILE%.*} # Set correct file name!
  if [ -h "$HOME/.${FILE##*/}" ]; then
    echo "  - Removing $HOME/.${FILE##*/}."
    rm "$HOME/.${FILE##*/}"
  else
    echo "  - $HOME/.${FILE##*/} doesn't exist."
  fi
done < <(find .. -type f -name "*.symlink")

##
# Remove ~/.bin folder and all files.
##
echo "- Removing \"~/.bin\" folder and files inside."

BIN="$HOME/.bin"

while IFS= read -r FILE
do
  FILE=${FILE%.*}
  echo "  - Checking $BIN/${FILE##*/}."
  if [ -f "$BIN/${FILE##*/}" ]; then
    echo "   - Removing $BIN/${FILE##*/}."
    rm "$BIN/${FILE##*/}"
  else
    echo "   - ${FILE##*/} doesn't exist."
  fi
done < <(find ../bin -type f -name "*.copy")

if [ -d "$HOME/.bin" ]; then
  echo "  - Folder \$HOME/.bin exists. Removing it."
  rmdir "$HOME/.bin"
else
  echo "  - Folder \$HOME/.bin doesn't exist."
fi
