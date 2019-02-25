#!/usr/bin/env ruby
require 'json'
require 'readline'

def intro_text
  puts "Welcome to Zendesk Search"
  puts "Type 'quit' to exit at any time, Press 'Enter' to continue"
  puts "\n\n"
  puts "\tSelect search options:"
  puts "\t * Press 1 to search Zendesk"
  puts "\t * Press 2 to view a list of searchable fields"
  puts "\t * Type 'quit' to exit"
  puts "\n\n"
end

def import_json
  hash_list = JSON.parse(File.read('organizations.json'))
  list = []

  hash_list.each do |org|
    list << Struct.new(*(k = org.keys.map(&:to_sym))).new(*org.values)
  end

  return list
end

intro_text
list = import_json

list.each do |org|
  puts "#{org._id} | #{org.name}"
end

puts "\n"

command = nil
while command != 'quit'
  command = Readline.readline(" ", true)
  break if command.nil?

  case command
  when '1'
#    search_term = Readline.readline("Enter search term  ", true)
    search_value = Readline.readline("Enter search ID  ", true)

    selected = list.select{|org| org._id == search_value.to_i}
    selected.each do |org|
      org.each_pair do |key,value|
        puts "#{key}\t\t#{value}"
      end
    end
  when '2'
    puts "This will list the searchable fields"
  end
end

