ORGANIZATION = [ :_id, :url, :external_id, :name, :domain_names, :created_at, :details, :shared_tickets, :tags ]

class Organization
  attr_accessor *ORGANIZATION

  def initialize(org) 
    ORGANIZATION.each do |attribute|
      # TODO test that extraneous fields are ignored, and missing ones get set to null
      eval "@#{attribute} = org[attribute.to_s]"
    end
  end

  def display
    ORGANIZATION.each do |field|
      printf "%-20s %s\n", field, self.send(field)
    end
  end

  def self.find(search_term, search_value, organizations)

    unless ORGANIZATION.include?(search_term.to_sym)
      Search.error "Search term not found"
      return
    end

    selected = organizations.select{|org| org.send(search_term) == search_value.to_i}

    if selected.count == 0
      Search.error "Search has no results"
    end

    selected.each do |org|
      org.display
    end
  end
end
