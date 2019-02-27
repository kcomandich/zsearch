require 'record'

USER = [ :_id, :url, :external_id, :name, :alias, :created_at, :active, :verified, :shared, :locale, :timezone, :last_login_at, :email, :phone, :signature, :organization_id, :tags, :suspended, :role ]

class User < Record
  @expected_fields = USER
  attr_accessor *USER
  attr_accessor :organizations, :submitted_tickets, :assigned_tickets

  def initialize(user)
    super
    @organizations = user[organizations]
    @submitted_tickets = user[submitted_tickets]
    @assigned_tickets = user[assigned_tickets]
  end

  def display
    result = super
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

end
