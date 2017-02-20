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

filepath = File.expand_path("../atom/packages.json", __dir__)

puts "Fetching packages information..."
packages = JSON.parse(`apm list -j`)
filtered_user_packages = []

packages['user'].each do |p|

    puts "Processing " + p['name'] + "..."
    package = Hash.new
    package['name'] = p['name']
    package['version'] = p['version']
    package['homepage'] = p['homepage']
    package['repository'] = p['repository']

    filtered_user_packages << package
end

puts "Writing to file..."

File.write(filepath, JSON.pretty_generate(filtered_user_packages))

puts "Done."
