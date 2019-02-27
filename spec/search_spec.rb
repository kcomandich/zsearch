require 'search'

RSpec.describe Search do

  describe "#error" do
    it 'returns a red string' do
      expect(Search.error("My message.")).to match(/31/)
    end
  end

  describe "#intro_text" do
    it 'welcomes the user' do
      s = Search.new
      expect { s.intro_text }.to output(/welcome/i).to_stdout
    end
  end

  describe "#main_menu" do
    it 'prints a list of options' do
      s = Search.new
      expect { s.main_menu }.to output(/options/).to_stdout
    end
  end

  describe "#initialize" do
    it 'populates the list of Users' do
      s = Search.new
      expect(s.users.count).to be > 0
    end
    it 'populates the list of Organizations' do
      s = Search.new
      expect(s.organizations.count).to be > 0
    end
    it 'populates the list of Tickets' do
      s = Search.new
      expect(s.tickets.count).to be > 0
    end
  end

  describe "#import_users" do
    it "gathers the user's organization" do
      s = Search.new
      s.import_users
      user1 = s.users[0]
      expect(user1.organizations.count).to be == 1
    end
    it "gathers the user's submitted tickets" do
      s = Search.new
      s.import_users
      user1 = s.users[0]
      expect(user1.submitted_tickets.count).to be == 2
    end
    it "gathers the user's assigned tickets" do
      s = Search.new
      s.import_users
      user1 = s.users[0]
      expect(user1.assigned_tickets.count).to be == 2
    end
  end
end
