class Search

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
  #    return USERS
    when '2'
  #    return TICKETS
    when '3'
      search_organizations
  #  else
      # TODO show error
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
    selected.each do |org|
      org.display
    end
  end
end
