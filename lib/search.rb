require 'json'
require 'organization'
require 'user'
require 'ticket'

RED = "\e[31m%s\e[0m"
GREEN = "\e[32m%s\e[0m"

# Tickets have one submitter, one assignee
# Tickets have one organization
# Users have many tickets, through the ticket data
# Users have one organization
# Organizations have many tickets, through the ticket data
# Organizations have many users, through the user data

class Search
    attr_accessor :users, :tickets, :organizations

  def initialize
    @users = []
    @tickets = []
    @organizations = []
    import_tickets
    import_organizations
    import_users
    import_associated_records
  end

  def self.error(msg)
    return sprintf RED, "#{msg}\n"
  end

  def intro_text
    puts "Welcome to Zendesk Search"
    puts "Type 'quit' to exit at any time"
    puts "\n"
  end

  def main_menu
    puts "\n"
    puts "\tSelect search options:"
    puts "\t * Press 1 to search Zendesk"
    puts "\t * Press 2 to view a list of searchable fields"
    puts "\t * Type 'quit' to exit"
    puts "\n"
  end

  def import_users
    hash_list = JSON.parse(File.read(User.file))

    hash_list.each do |user|
      @users << User.new(user)
    end
  end

  def import_tickets
    hash_list = JSON.parse(File.read(Ticket.file))

    hash_list.each do |ticket|
      @tickets << Ticket.new(ticket)
    end
  end

  def import_organizations
    hash_list = JSON.parse(File.read(Organization.file))

    hash_list.each do |org|
      @organizations << Organization.new(org)
    end
  end

  def import_associated_records
    @users.each do |user|
      user.organizations = Organization.find('_id', user.organization_id, @organizations)
      user.submitted_tickets = Ticket.find('submitter_id', user._id, @tickets)
      user.assigned_tickets = Ticket.find('assignee_id', user._id, @tickets)
    end

    @tickets.each do |ticket|
      ticket.submitter = User.find('_id', ticket.submitter_id, @users)[0]
      ticket.assignee = User.find('_id', ticket.assignee_id, @users)[0]
      ticket.organization = Organization.find('_id', ticket.organization_id, @organizations)[0]
    end

    @organizations.each do |org|
      org.tickets = Ticket.find('organization_id', org._id, @tickets)
      org.users = User.find('organization_id', org._id, @users)
    end
  end

  def accept_commands
    intro_text
    command = nil
    while command != 'quit'
      main_menu
      command = Readline.readline(" ", true)
      break if command.nil?

      case command
      when '1'
        choose_dataset
      when '2'
        puts "Search Users with\n"
        puts USER.each{|field| "#{field}\n"}
        puts '--------------------------------------'
        puts "Search Tickets with\n"
        puts TICKET.each{|field| "#{field}\n"}
        puts '--------------------------------------'
        puts "Search Organizations with\n"
        puts ORGANIZATION.each{|field| "#{field}\n"}
      when 'quit', 'exit'
        break
      else
        STDERR.puts Search.error 'Invalid option'
      end
    end
  end

  def choose_dataset
    dataset = Readline.readline("Select 1) Users or 2) Tickets or 3) Organizations\n ", true)
    case dataset
    when '1'
      search_term = Readline.readline("Enter search term  ", true)
      search_value = Readline.readline("Enter search value  ", true)
      u = User.find(search_term, search_value, @users)
      if u.count == 0
        puts Search.error "No users match"
      end

      u.each do |user|
        puts user.display
      end
    when '2'
      search_term = Readline.readline("Enter search term  ", true)
      search_value = Readline.readline("Enter search value  ", true)
      t = Ticket.find(search_term, search_value, @tickets)
      if t.count == 0
        puts Search.error "No tickets match"
      end

      t.each do |ticket|
        puts ticket.display
      end
    when '3'
      search_term = Readline.readline("Enter search term  ", true)
      search_value = Readline.readline("Enter search value  ", true)
      o = Organization.find(search_term, search_value, @organizations)
      if o.count == 0
        puts Search.error "No organizations match"
      end
      o.each do |org|
        puts org.display
      end
    else
      STDERR.puts Search.error 'Invalid option'
    end
  end
end
