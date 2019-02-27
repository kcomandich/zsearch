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
    result = ''
    ORGANIZATION.each do |field|
      result.concat sprintf "%-20s %s\n", field, self.send(field)
    end
    return result
  end

  def self.find(search_term, search_value, organizations)

    unless ORGANIZATION.include?(search_term.to_sym)
      STDERR.puts Search.error "Search term not found"
      return []
    end

    return organizations.select{|org| org.send(search_term).to_s == search_value}
  end
end
