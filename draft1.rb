#!/usr/bin/env ruby
require 'json'
require 'readline'

$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'organization'
require 'user'
require 'ticket'
require 'search'

def intro_text
  puts "Welcome to Zendesk Search"
  puts "Type 'quit' to exit at any time"
  puts "\n"
end

intro_text
search = Search.new
search.import_organizations
search.accept_commands

