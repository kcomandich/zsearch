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
    @tickets = Ticket.import
    @organizations = Organization.import
    @users = User.import
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

  def print_searchable_fields
    User.searchable_fields
    Ticket.searchable_fields
    Organization.searchable_fields
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
        print_searchable_fields
      when 'quit', 'exit'
        break
      else
        STDERR.puts Search.error 'Invalid option'
      end
    end
  end

  def choose_dataset
    dataset = Readline.readline("Select 1) Users or 2) Tickets or 3) Organizations\n ", true)

    unless %w[ 1 2 3 ].include? dataset
      STDERR.puts Search.error 'Invalid option'
      return
    end

    search_term = Readline.readline("Enter search term  ", true)
    search_value = Readline.readline("Enter search value  ", true)

    case dataset
    when '1'
      User.find_and_display(search_term, search_value, @users)
    when '2'
      Ticket.find_and_display(search_term, search_value, @tickets)
    when '3'
      Organization.find_and_display(search_term, search_value, @organizations)
    end
  end
end
