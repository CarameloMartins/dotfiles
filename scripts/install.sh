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

for FILE in $(find .. -type f -name "*install.sh" | grep -v "scripts"); do
  echo "Running '${FILE%.*}'."
  ${FILE}
done
