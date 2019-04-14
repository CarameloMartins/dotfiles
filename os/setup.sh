echo "Distribution: $(lsb_release -ds)."

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

bash ./remove_dirs.sh
bash ./create_directories.sh

bash ./install/update.sh

bash ./install/basics.sh
bash ./install/databases.sh
bash ./install/development.sh
bash ./install/docker.sh
bash ./install/libraries.sh
bash ./install/misc.sh
bash ./install/ui.sh

bash ./install/remove.sh

bash ./install/cleanup.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

bash ./clone.sh

echo "Success!"