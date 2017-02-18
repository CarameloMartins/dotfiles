#!/usr/bin/ruby

# atom_packages.py
#
# Fetch relevant information regarding user installed atom packages and store it
# on a specified location.
#
# Information should be:
#   - name
#   - version
#   - homepage
#   - repository

require 'rubygems'
require 'json'

filename = "packages.json"
filepath = File.expand_path("../atom/", __dir__)
packages = JSON.parse(`apm list -j`)

File.open(filepath + "/" + filename, "w") do |f|
    f.write(packages['user'])
end
