require 'search'
require 'readline'

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
    
    it "gathers the user's organization" do
      s = Search.new
      user1 = s.users[0]
      expect(user1.organizations.count).to be == 1
    end
    it "gathers the user's submitted tickets" do
      s = Search.new
      user1 = s.users[0]
      expect(user1.submitted_tickets.count).to be == 2
    end
    it "gathers the user's assigned tickets" do
      s = Search.new
      user1 = s.users[0]
      expect(user1.assigned_tickets.count).to be == 2
    end
    it "gathers the ticket's two users" do
      s = Search.new
      ticket1 = s.tickets[0]
      expect(ticket1.submitter.name).to eq("Elma Castro")
      expect(ticket1.assignee.name).to eq("Harris Côpeland")
    end
  end

  describe "#accept_commands" do
    it "quits when the user chooses quit" do
      s = Search.new
      allow(Readline).to receive(:readline).exactly(1).times.and_return('quit')
      expect{s.accept_commands}.to output(/search options/).to_stdout
    end
    it "quits when the user chooses exit" do
      s = Search.new
      allow(Readline).to receive(:readline).exactly(1).times.and_return('exit')
      expect{s.accept_commands}.to output(/search options/).to_stdout
    end
  end

  describe "#choose_dataset" do
    it "returns with an error if the user chooses an invalid option" do
      s = Search.new
      expect{s.choose_dataset('4')}.to output(a_string_including("Invalid")).to_stderr_from_any_process
    end

    it "displays results if a correct search term and value is entered" do
      allow(Readline).to receive(:readline).exactly(2).times.and_return('_id', '1')
      s = Search.new
      expect {s.choose_dataset('1')}.to output(/Francisca Rasmussen/).to_stdout
    end
  end
end
