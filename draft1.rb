#!/usr/bin/env ruby
require 'json'
require 'readline'

ORGANIZATION = [ :_id, :url, :external_id, :name, :domain_names, :created_at, :details, :shared_tickets, :tags ]

# TODO validate the JSON file against this structure
class Organization
  attr_accessor *ORGANIZATION
  def initialize(org_fields) 

    ORGANIZATION.each do |attribute|
     eval "@#{attribute} = org_fields[attribute.to_s]"
   end
  end

  def display
    ORGANIZATION.each do |field|
      puts "#{field}\t\t#{self.send(field)}"
    end
  end
end
User = Struct.new(:_id, :url, :external_id, :name, :alias, :created_at, :active, :verified, :shared, :locale, :timezone, :last_login_at, :email, :phone, :signature, :organization_id, :tags, :suspended, :role)
Ticket = Struct.new(:_id, :url, :external_id, :created_at, :type, :subject, :description, :priority, :status, :submitter_id, :assignee_id, :organization_id, :tags, :has_incidents, :due_at, :via)

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
    # TODO use my fixed list, so that extraneous fields are ignored, and missing ones get set to null
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

