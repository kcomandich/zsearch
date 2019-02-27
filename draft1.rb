#!/usr/bin/env ruby
require 'readline'

$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'search'

search = Search.new
search.accept_commands

