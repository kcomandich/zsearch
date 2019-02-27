RED = "\e[31m%s\e[0m"
GREEN = "\e[32m%s\e[0m"

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
        puts "Search Organizations with\n"
        puts ORGANIZATION.each{|field| "#{field}\n"}
      when 'quit', 'exit'
        break
      else
        puts error 'Invalid option'
      end
    end
  end

  def choose_dataset
    dataset = Readline.readline("Select 1) Users or 2) Tickets or 3) Organizations\n ", true)
    case dataset
    when '1'
      search_term = Readline.readline("Enter search term  ", true)
      search_value = Readline.readline("Enter search ID  ", true)
      puts User.find(search_term, search_value, @users)
    when '2'
      search_term = Readline.readline("Enter search term  ", true)
      search_value = Readline.readline("Enter search ID  ", true)
      puts Ticket.find(search_term, search_value, @tickets)
    when '3'
      search_term = Readline.readline("Enter search term  ", true)
      search_value = Readline.readline("Enter search ID  ", true)
      puts Organization.find(search_term, search_value, @organizations)
    else
      puts error 'Invalid option'
    end
  end
end
