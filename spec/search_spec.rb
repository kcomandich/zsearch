require 'search'

RSpec.describe Search do

  describe "#error" do
    it 'returns a red string' do
      expect(Search.error("My message.")).to match(/31/)
    end
  end

  describe "#main_menu" do
    it 'prints a list of options' do
      s = Search.new
      expect { s.main_menu }.to output(/options/).to_stdout
    end
  end

  describe "#import_users" do
    it 'populates the @users variable' do
      s = Search.new
      expect(s.users.count).to be == 0
      s.import_users
      expect(s.users.count).to be > 0
    end
  end
end
