#!/usr/bin/env bash
#
# Perfom a 'shellcheck' in all bash scripts. The script is used in Travis CI.

##
# This function is used to be able to tell where a script file is and enter its
# directory
#
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "$1" )" && pwd )"
cd "$DIR" || exit

echo

# Global Variables
SUCCESS=0
FAIL=0

while IFS= read -r FILE
do
  echo -n "Running test for ${FILE}... "

  let COUNTER++

  if shellcheck "${FILE}"; then
    echo "success."
    let SUCCESS++
  else
    echo "failure."
    let FAIL++
  fi
done < <(find .. -type f -name "*.sh")

echo -e "\n$SUCCESS passed and $FAIL failed."

if [ $FAIL -ne 0 ]; then
  exit 1
fi
