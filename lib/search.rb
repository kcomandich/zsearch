RED = "\e[31m%s\e[0m"
GREEN = "\e[32m%s\e[0m"

# Tickets have one submitter, one assignee
# Tickets have one organization
# Users have many tickets, through the ticket data
# Users have one organization
# Organizations have many tickets, through the ticket data
# Organizations have many users, through the user data

class Search

  def self.error(msg)
    return sprintf RED, "#{msg}\n"
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
    hash_list = JSON.parse(File.read('users.json'))
    @users = []

    hash_list.each do |user|
      u = User.new(user)
      if u.organization_id
        u.organizations = Organization.find('_id', u.organization_id, @organizations)
      end
      u.submitted_tickets = Ticket.find('submitter_id', u._id, @tickets)
      u.assigned_tickets = Ticket.find('assignee_id', u._id, @tickets)
      @users << u
    end
  end

  def import_tickets
    hash_list = JSON.parse(File.read('tickets.json'))
    @tickets = []

    hash_list.each do |ticket|
      @tickets << Ticket.new(ticket)
    end
  end

  def import_organizations
    hash_list = JSON.parse(File.read('organizations.json'))
    @organizations = []

    hash_list.each do |org|
      @organizations << Organization.new(org)
    end
  end
 
  def accept_commands
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
      search_value = Readline.readline("Enter search ID  ", true)
      u = User.find(search_term, search_value, @users)
      if u.count == 0
        puts Search.error "No users match"
      end

      u.each do |user|
        puts user.display
      end
    when '2'
      search_term = Readline.readline("Enter search term  ", true)
      search_value = Readline.readline("Enter search ID  ", true)
      t = Ticket.find(search_term, search_value, @tickets)
      if t.count == 0
        puts Search.error "No tickets match"
      end

      t.each do |ticket|
        puts ticket.display
      end
    when '3'
      search_term = Readline.readline("Enter search term  ", true)
      search_value = Readline.readline("Enter search ID  ", true)
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
