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

 hash_list = JSON.parse(contents)
 list = []

 hash_list.each do |org|
  list << Struct.new(*(k = org.keys.map(&:to_sym))).new(*org.values)
 end

 list.each do |org|
  puts "#{org._id} | #{org.name}"
 end

 # Search Organizations for id 121
 puts list.select{|org| org._id == 121}

end
