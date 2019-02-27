require 'json'
require 'record'

TICKET = [ :_id, :url, :external_id, :created_at, :type, :subject, :description, :priority, :status, :submitter_id, :assignee_id, :organization_id, :tags, :has_incidents, :due_at, :via ]
TICKET_FILE = 'data/tickets.json'

class Ticket < Record
  @expected_fields = TICKET
  @file = TICKET_FILE
  @record_name = 'Tickets'
  attr_accessor *TICKET
  attr_accessor :submitter, :assignee, :organization

  def initialize(ticket)
    super
  end

  def display
    result = super
    result.concat sprintf "%-20s", 'Organization'
    result.concat @organization.name
    result.concat "\n"
    result.concat sprintf "%-20s", 'Submitter'
    result.concat @submitter.name
    result.concat "\n"
    result.concat sprintf "%-20s", 'Assignee'
    result.concat @assignee.name
    result.concat "\n"
  end

  def self.import
    hash_list = JSON.parse(File.read(@file))
    return hash_list.map{|ticket| Ticket.new(ticket)}
  end
end

