# !/bin/bash
# Install script for Terminal settings.

# Source: http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

for FILE in $(find -type f -name "bash*"); do
  if [ ! -h "$HOME/.${FILE##*/}" ]; then
    echo "- Installing $HOME/.${FILE##*/}..."
    ln -s "$DIR/${FILE##*/}" "$HOME/.${FILE##*/}"
  else
    echo "- $HOME/.${FILE##*/} already exists!"
  fi
done
