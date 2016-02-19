#!/usr/bin/env bash
#
# Install git basic configuration files.

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
# Install global .gitignore.
##
if [ ! -h "$HOME/.gitignore" ]; then
  echo "- Installing global .gitignore."
  ln -s "$DIR/gitignore.symlink" "$HOME/.gitignore"
else
  echo "- A global .gitignore file already exists."
fi

##
# Install gitconfig.
##

if [ ! -f "$HOME/.gitconfig" ]; then
  echo "- Installing .gitconfig."
  cp "$DIR/gitconfig.copy" "$HOME/.gitconfig"

  # Set Git name.
  read -p "  - What's your Git name? " NAME
  sed -i "s/\[GIT-NAME]/'$NAME'/g" "$HOME/.gitconfig"

  # Set Git email.
  read -p "  - What's your Git email? " EMAIL
  sed -i "s/\[GIT-EMAIL]/'$EMAIL'/g" "$HOME/.gitconfig"
else
  echo "- A gitconfig file already exists."
 fi
