require 'user'
require 'search'

RSpec.describe User do

  describe '#find' do
    it 'returns an error if the search term is not found' do
      expect { User.find('fake', 1, []) }.to output(a_string_including("Search term not found")).to_stderr_from_any_process
    end

    it 'returns a list of users that match an integer search criteria' do
      dot = User.new( '_id' => 1 )
      hugh = User.new( '_id' =>  2 )
      expect(User.find('_id', '2', [ dot, hugh ])).to eq([ hugh ])
    end

    it 'returns a list of users that match a string search criteria' do
      dot = User.new( 'name' => 'Dot' )
      hugh = User.new( 'name' => 'Hugh' )
      expect(User.find('name', 'Dot', [ dot, hugh ])).to eq([ dot ])
    end
  end
end
