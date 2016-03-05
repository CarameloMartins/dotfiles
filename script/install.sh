#!/usr/bin/env bash
#
# Install dotfiles, configurations and packages in a machine.

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
# Install gitconfig with correct configurations.
##
if [ ! -f "$HOME/.gitconfig" ]; then
  echo "- Installing .gitconfig."
  cp "$DOTFILES/git/gitconfig.copy" "$HOME/.gitconfig"

  # Set Git name.
  read -p "  - What's your Git name? " NAME
  sed -i "s/\[GIT-NAME]/'$NAME'/g" "$HOME/.gitconfig"

  # Set Git email.
  read -p "  - What's your Git email? " EMAIL
  sed -i "s/\[GIT-EMAIL]/'$EMAIL'/g" "$HOME/.gitconfig"
else
  echo "- A gitconfig file already exists."
fi

##
# Symlink files with `symlink` extension to $HOME folder.
##
echo "- Starting to link files to \"$HOME\":"

while IFS= read -r FILE
do
  FILE=${FILE%.*} # Set correct file name!
  FILEPATH=$(readlink -f "$FILE.symlink")

  if [ ! -h "$HOME/.${FILE##*/}" ]; then
    echo "  - Installing $HOME/.${FILE##*/}."
    ln -s "$FILEPATH" "$HOME/.${FILE##*/}"
  else
    echo "  - $HOME/.${FILE##*/} already exists."
  fi
done < <(find .. -type f -name "*.symlink")

##
# Install ~/.bin folder and copy needed files.
##
echo "- Installing ~./bin folder."

if [ ! -d "$HOME/.bin" ]; then
  echo "  - Folder \$HOME/.bin doesn't exist. Creating it."
  mkdir "$HOME/.bin"
else
  echo "  - Folder \$HOME/.bin already exists."
fi

BIN="$HOME/.bin"

while IFS= read -r FILE
do
  FILE=${FILE%.*}
  FILEPATH=$(readlink -f "$FILE.copy")

  echo "  - Checking $BIN/${FILE##*/}."
  if [ ! -f "$BIN/${FILE##*/}" ]; then
    echo "   - Installing $BIN/${FILE##*/}."
    cp "$FILEPATH" "$BIN/${FILE##*/}"
    chmod +x "$BIN/${FILE##*/}"
  else
    echo "   - ${FILE##*/} already exists."
  fi
done <  <(find ../bin -type f -name "*")

##
# Install 'Atom' configuration files if Atom is currently installed.
##
echo "- Installing Atom configurations to ~./atom folder."

if [ -d ~/.atom ]; then
  echo "  - Atom is installed. Installing configurations."

  while IFS= read -r FILE
  do
    FILEPATH=$(readlink -f "$FILE")

    if [ ! -h "$HOME/.atom/${FILE##*/}" ]; then
      echo "  - Installing $HOME/.atom/${FILE##*/}."
      ln -s "$FILEPATH" "$HOME/.atom/${FILE##*/}"
    else
      echo "  - $HOME/.atom/${FILE##*/} already exists."
    fi
  done < <(find ../atom -type f)

else
  echo "  - Atom is not currently installed. Install Atom before installing configurations."
fi
