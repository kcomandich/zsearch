#!/usr/bin/env ruby
require 'json'

puts "Welcome to Zendesk Search"
puts "Type 'quit' to exit at any time, Press 'Enter' to continue"
puts "\n\n"
puts "\tSelect search options:"
puts "\t * Press 1 to search Zendesk"
puts "\t * Press 2 to view a list of searchable fields"
puts "\t * Type 'quit' to exit"
puts "\n\n"

contents = ''

File.open('organizations.json','r') do |file|
 file.readlines.each do |line|
   contents += line
 end

 my_hash = JSON.parse(contents)

 my_hash.each do |organization|
  puts "ID: #{organization['_id']}"
  puts "Name: #{organization['name']}"
 end
end
