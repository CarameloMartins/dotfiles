#!/usr/bin/env bash

# Retrieve my external IP.

echo "IP Address: $(wget http://ipinfo.io/ip -qO -)"
