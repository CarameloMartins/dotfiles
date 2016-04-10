#!/usr/bin/env bash
#
# Update machine.

apt-get update && apt-get upgrade
apt-get autoremove
