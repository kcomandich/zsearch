#!/usr/bin/env ruby

puts "Welcome to Zendesk Search"
puts "Type 'quit' to exit at any time, Press 'Enter' to continue"
puts "\n\n"
puts "\tSelect search options:"
puts "\t * Press 1 to search Zendesk"
puts "\t * Press 2 to view a list of searchable fields"
puts "\t * Type 'quit' to exit"
puts "\n\n"

File.open('organizations.json','r') do |file|
 file.readlines.each do |line|
   puts line
 end
end
