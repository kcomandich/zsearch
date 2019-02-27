require 'record'

TICKET = [ :_id, :url, :external_id, :created_at, :type, :subject, :description, :priority, :status, :submitter_id, :assignee_id, :organization_id, :tags, :has_incidents, :due_at, :via ]

class Ticket < Record
  @expected_fields = TICKET
  attr_accessor *TICKET

  def initialize(ticket)
    super
  end

  def display
    result = ''
    TICKET.each do |field|
      result.concat sprintf "%-20s %s\n", field, self.send(field)
    end
    return result
  end

end

