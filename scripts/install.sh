#!/usr/bin/env bash
#
# Run all install.sh scripts.

##
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

for FILE in $(find .. -type f -name "*install.sh" | grep -v "scripts"); do
  echo "Running '${FILE%.*}'."
  ${FILE}
done
