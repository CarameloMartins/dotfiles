#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Run all remove.sh scripts.
#-------------------------------------------------------------------------------

##
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

find .. -type f -name "*remove.sh" | grep -v "scripts" |
while read FILE
do
  echo "Running '${FILE}'."
  ${FILE}
done
