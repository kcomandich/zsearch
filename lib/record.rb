class Record
  @expected_fields = []
  class << self
    attr_accessor :expected_fields
    attr_accessor :file
  end

  def initialize(record)
    self.class.expected_fields.each do |attribute|
      eval "@#{attribute} = record[attribute.to_s]"
    end
  end

  def display
    result = ''
    self.class.expected_fields.each do |field|
      result.concat sprintf "%-20s %s\n", field, self.send(field)
    end
    return result
  end

  def self.find(search_term, search_value, list)
    unless @expected_fields.include?(search_term.to_sym)
      STDERR.puts Search.error "Search term not found"
      return []
    end

    return list.select{|record| record.send(search_term).to_s == search_value.to_s}
  end

  def self.display_searchable_fields
    puts '--------------------------------------'
    puts "Search #{@record_name} with\n"
    puts @expected_fields.join(', ')
    puts '--------------------------------------'
  end

  def self.find_and_display(search_term, search_value, list)
    results = self.find(search_term, search_value, list)
    if results.count == 0
      puts Search.error "No #{@record_name} Match"
    end

    results.each do |result|
      puts result.display
    end
  end
end
