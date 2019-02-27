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

  def self.searchable_fields
    puts '--------------------------------------'
    puts "Search #{@record_name} with\n"
    puts @expected_fields.each{|field| "#{field}\n"}
  end
end
