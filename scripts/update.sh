#!/usr/bin/env bash

# Update machine the machine.

echo "Updating apt-get..."
apt-get update -y > /dev/null

echo "Upgrading machine...."
apt-get upgrade -y > /dev/null

echo "Using autoremove to uninstall..."
apt-get autoremove -y > /dev/null
