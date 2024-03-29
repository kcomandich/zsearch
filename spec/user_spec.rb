require 'user'

RSpec.describe User do

  describe '#find' do
    it 'returns a list of users that match an integer search criteria' do
      francesca = User.new( '_id' => 1 )
      cross = User.new( '_id' =>  2 )
      expect(User.find('_id', '2', [ francesca, cross ])).to eq([ cross ])
    end

    it 'returns a list of users that match a string search criteria' do
      francesca = User.new( 'name' => 'Francisca Rasmussen' )
      cross = User.new( 'name' => 'Cross Barlow' )
      expect(User.find('name', 'Francisca Rasmussen', [ francesca, cross ])).to eq([ francesca ])
    end
  end
end
