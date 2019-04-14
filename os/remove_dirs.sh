#!/bin/bash

. ./utils.sh

echo "Removing default directories from installation..."

rm_file ~/examples.desktop

rm_dir ~/Documents/ 
rm_dir ~/Music/ 
rm_dir ~/Pictures/ 
rm_dir ~/Public/ 
rm_dir ~/Templates/ 
rm_dir ~/Videos/