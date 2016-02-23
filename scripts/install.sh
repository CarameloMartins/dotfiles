#!/usr/bin/env bash
#
# Run all install.sh scripts.

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
# Get all files that end with *.copy and copy them to "~/".
##

## Get all files that end with *.symlink and symlink them to "~/".
##

##
# Install Atom editor configuration files, packages and themes.
##

##
# Install bin files. Copy them to "~/.bin"and generate "~./bin" if needed.
##

##
# Call install.sh script inside git folder to install git files.
# This can't be automatic because ".gitignore" needs to have some scripts
# replaced.
##


for FILE in $(find .. -type f -name "*install.sh" | grep -v "scripts"); do
  echo "Running '${FILE%.*}'."
  ${FILE}
done
