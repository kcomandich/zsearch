TICKET = [ :_id, :url, :external_id, :created_at, :type, :subject, :description, :priority, :status, :submitter_id, :assignee_id, :organization_id, :tags, :has_incidents, :due_at, :via ]
class Ticket
  attr_accessor *TICKET

  def initialize(ticket)
    TICKET.each do |attribute|
      eval "@#{attribute} = ticket[attribute.to_s]"
    end
  end

  def display
    result = ''
    TICKET.each do |field|
      result.concat sprintf "%-20s %s\n", field, self.send(field)
    end
    return result
  end

  def self.find(search_term, search_value, tickets)

    unless TICKET.include?(search_term.to_sym)
      return Search.error "Search term not found"
    end

    selected = tickets.select{|ticket| ticket.send(search_term) == search_value.to_i}

    if selected.count == 0
      return Search.error "No tickets match"
    end

    selected.each do |ticket|
      return ticket.display
    end
  end
end

