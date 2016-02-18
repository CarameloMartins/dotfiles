#!/usr/bin/env bash
#
# Perfom a 'shellcheck' in all bash scripts. The script is used in Travis CI.

##
# Source:
#   http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
##
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

SUCCESS=0
FAIL=0

while IFS= read -r FILE
do
  echo "Running test for '${FILE}'."

  let COUNTER++

  if shellcheck "${FILE}"; then
    echo "- Test was successful."
    let SUCCESS++
  else
    echo "- Test failed."
    let FAIL++
  fi
done < <(find .. -type f -name "*.sh")

echo -e "\nResults: $SUCCESS passed and $FAIL failed."

if [ $FAIL -ne 0 ]; then
  exit 1
fi
