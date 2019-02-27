require 'record'

ORGANIZATION = [ :_id, :url, :external_id, :name, :domain_names, :created_at, :details, :shared_tickets, :tags ]
ORGANIZATION_FILE = 'data/organizations.json'

class Organization < Record
  @expected_fields = ORGANIZATION
  @file = ORGANIZATION_FILE
  attr_accessor *ORGANIZATION
  attr_accessor :tickets, :users

  def initialize(org) 
    super
  end

  def display
    result = super
    result.concat sprintf "%-20s", 'Users'
    result.concat @users.map{|item| item.name }.join(', ')
    result.concat "\n"
    result.concat sprintf "%-20s", 'Tickets'
    result.concat @tickets.map{|item| item.subject }.join(', ')
    result.concat "\n"
  end
end
