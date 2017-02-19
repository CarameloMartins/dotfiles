#!/usr/bin/ruby

# refresh_ap.rb
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
user_packages = packages['user']
filtered_user_packages = []

user_packages.each do |p|
    package = Hash.new
    package['name'] = p['name']
    package['version'] = p['version']
    package['homepage'] = p['homepage']
    package['repository'] = p['repository']
    filtered_user_packages << package
end

File.write(filepath + "/" + filename, JSON.pretty_generate(filtered_user_packages))
