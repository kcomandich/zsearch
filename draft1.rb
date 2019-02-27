#!/usr/bin/env ruby
require 'readline'

$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'search'

def intro_text
  puts "Welcome to Zendesk Search"
  puts "Type 'quit' to exit at any time"
  puts "\n"
end

intro_text
search = Search.new
search.accept_commands

