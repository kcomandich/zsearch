TICKET = [ :_id, :url, :external_id, :created_at, :type, :subject, :description, :priority, :status, :submitter_id, :assignee_id, :organization_id, :tags, :has_incidents, :due_at, :via ]
class Ticket
  attr_accessor *TICKET

  def initialize(ticket)
    TICKET.each do |attribute|
      eval "@#{attribute} = ticket[attribute.to_s]"
    end
  end

  def display
    TICKET.each do |field|
      printf "%-20s %s\n", field, self.send(field)
    end
  end
end

