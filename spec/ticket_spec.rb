require 'ticket'

RSpec.describe Ticket do

  describe "#find" do
    it 'returns a list of tickets that match an integer search criteria' do
      korea = Ticket.new( 'subject' => "A Catastrophe in Korea (North)", 'submitter_id' => 38 )
      micronesia = Ticket.new( 'subject' => "A Catastrophe in Micronesia", 'submitter_id' => 71 )
      wallis = Ticket.new( 'subject' => "A Drama in Wallis and Futuna Islands", 'submitter_id' => 71 )
      australia = Ticket.new( 'subject' => "A Drama in Australia", 'submitter_id' => 71 )
      expect(Ticket.find('submitter_id', '71', [ korea, micronesia, wallis, australia ])).to eq([ micronesia, wallis, australia ])
    end

    it 'returns a list of tickets that match a string search criteria' do
      korea = Ticket.new( 'subject' => 'A Catastrophe in Korea (North)' )
      micronesia = Ticket.new( 'subject' => 'A Catastrophe in Micronesia' )
      expect(Ticket.find('subject', 'A Catastrophe in Korea (North)', [ korea, micronesia ])).to eq([ korea ])
    end

    it 'returns tickets when searching for an empty description' do
      korea = Ticket.new( 'subject' => 'A Catastrophe in Korea (North)', 'description' => '' )
      expect(Ticket.find('description', '', [ korea ])).to eq([ korea ])
    end
  end
end
