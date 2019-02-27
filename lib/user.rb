require 'json'
require 'record'

USER = [ :_id, :url, :external_id, :name, :alias, :created_at, :active, :verified, :shared, :locale, :timezone, :last_login_at, :email, :phone, :signature, :organization_id, :tags, :suspended, :role ]
USER_FILE = 'data/users.json'

class User < Record
  @expected_fields = USER
  @file = USER_FILE
  attr_accessor *USER
  attr_accessor :organizations, :submitted_tickets, :assigned_tickets

  def initialize(user)
    super
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

  def self.import
    hash_list = JSON.parse(File.read(@file))
    return hash_list.map{|user| User.new(user)}
  end

end
