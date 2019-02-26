class Search

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
      @users << User.new(user)
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
      end
    end
  end

  def choose_dataset
    dataset = Readline.readline("Select 1) Users or 2) Tickets or 3) Organizations\n ", true)
    case dataset
    when '1'
      search_users
    when '2'
      search_tickets
    when '3'
      search_organizations
  #  else
      # TODO show error
    end
  end

  def search_users
    search_term = Readline.readline("Enter search term  ", true)
    search_value = Readline.readline("Enter search ID  ", true)

    unless USER.include?(search_term.to_sym)
      puts "Search term not found"
      return
    end

    selected = @users.select{|user| user.send(search_term) == search_value.to_i}

    if selected.count == 0
      puts "Search has no results"
    end

    selected.each do |user|
      user.display
    end
  end

  def search_tickets
    search_term = Readline.readline("Enter search term  ", true)
    search_value = Readline.readline("Enter search ID  ", true)

    unless TICKET.include?(search_term.to_sym)
      puts "Search term not found"
      return
    end

    selected = @tickets.select{|ticket| ticket.send(search_term) == search_value.to_i}

    if selected.count == 0
      puts "Search has no results"
    end

    selected.each do |ticket|
      ticket.display
    end
  end

  def search_organizations
    search_term = Readline.readline("Enter search term  ", true)
    search_value = Readline.readline("Enter search ID  ", true)

    unless ORGANIZATION.include?(search_term.to_sym)
      puts "Search term not found"
      return
    end

    selected = @organizations.select{|org| org.send(search_term) == search_value.to_i}

    if selected.count == 0
      puts "Search has no results"
    end

    selected.each do |org|
      org.display
    end
  end
end
