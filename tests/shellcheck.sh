#!/usr/bin/env bash
#
# Perfom a 'shellcheck' in all bash scripts. The script is used in Travis CI.

##
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

find .. -type f -name "*.sh" |
while read FILE
do
  echo "Running test for '${FILE}'."

  if shellcheck "${FILE}"; then
    echo "- Test was successful."
  else
    echo "- Test failed."
    exit 1
  fi
done

exit 0
