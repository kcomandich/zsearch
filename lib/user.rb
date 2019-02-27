USER = [ :_id, :url, :external_id, :name, :alias, :created_at, :active, :verified, :shared, :locale, :timezone, :last_login_at, :email, :phone, :signature, :organization_id, :tags, :suspended, :role ]

class User
  attr_accessor *USER
  attr_accessor :organizations, :submitted_tickets, :assigned_tickets

  def initialize(user)
    USER.each do |attribute|
      eval "@#{attribute} = user[attribute.to_s]"
    end
    @organizations = user[organizations]
    @submitted_tickets = user[submitted_tickets]
    @assigned_tickets = user[assigned_tickets]
  end

  def display
    result = ''
    USER.each do |field|
      result.concat sprintf "%-20s %s\n", field, self.send(field)
    end
    result.concat sprintf "%-20s", 'Organizations'
    result.concat @organizations.map{|item| item.name }.join(', ')
    result.concat "\n"
    result.concat sprintf "%-20s", 'Submitted Tickets'
    result.concat @submitted_tickets.map{|item| item.subject }.join(', ')
    result.concat "\n"
    result.concat sprintf "%-20s", 'Assigned Tickets'
    result.concat @assigned_tickets.map{|item| item.subject }.join(', ')
    result.concat "\n"

    return result
  end

  def self.find(search_term, search_value, users)

    unless USER.include?(search_term.to_sym)
      STDERR.puts Search.error "Search term not found"
      return []
    end

    return users.select{|user| user.send(search_term) == search_value.to_i}
  end

end
