require 'organization'

RSpec.describe Organization do

  describe "#find" do

    it 'returns a list of organizations that match an integer search criteria' do
      kindaloo = Organization.new( '_id' =>  110 )
      speedbolt = Organization.new( '_id' => 111 )
      expect(Organization.find('_id', '110', [ kindaloo, speedbolt ])).to eq([ kindaloo ])
    end
  end
end
