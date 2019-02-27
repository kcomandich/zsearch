class Record
  @expected_fields = []
  class << self
    attr_accessor :expected_fields
  end

  def initialize(record)
    self.class.expected_fields.each do |attribute|
      eval "@#{attribute} = record[attribute.to_s]"
    end
  end

  def self.find(search_term, search_value, list)
    unless @expected_fields.include?(search_term.to_sym)
      STDERR.puts Search.error "Search term not found"
      return []
    end

    return list.select{|record| record.send(search_term).to_s == search_value}
  end
end
