#!/usr/bin/env ruby
require 'json'
require 'readline'

$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'organization'
require 'user'
require 'ticket'

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
    list << Organization.new(org)
  end

  return list
end

def search(list)
  search_term = Readline.readline("Enter search term  ", true)
  search_value = Readline.readline("Enter search ID  ", true)

  unless ORGANIZATION.include?(search_term.to_sym)
    puts "Search term not found"
    return
  end

  selected = list.select{|org| org.send(search_term) == search_value.to_i}
  selected.each do |org|
    org.display
  end
end
 
def accept_commands(list)
  command = nil
  while command != 'quit'
    command = Readline.readline(" ", true)
    break if command.nil?

    case command
    when '1'
      search(list)
    when '2'
      puts "Search Organizations with\n"
      puts ORGANIZATION.each{|field| "#{field}\n"}
    end
  end
end

intro_text
list = import_json
accept_commands(list)

