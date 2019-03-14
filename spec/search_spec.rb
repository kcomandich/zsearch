require 'search'
require 'readline'

RSpec.describe Search do

  before :each do
    @s = Search.new
  end

  describe "#error" do
    it 'returns a red string' do
      expect(Search.error("My message.")).to match(/31/)
    end
  end

  describe "#intro_text" do
    it 'welcomes the user' do
      expect { @s.intro_text }.to output(/welcome/i).to_stdout
    end
  end

  describe "#main_menu" do
    it 'prints a list of options' do
      expect { @s.main_menu }.to output(/options/).to_stdout
    end
  end

  describe "#initialize" do
    it 'populates the list of Users' do
      expect(@s.users.count).to be > 0
    end
    it 'populates the list of Organizations' do
      expect(@s.organizations.count).to be > 0
    end
    it 'populates the list of Tickets' do
      expect(@s.tickets.count).to be > 0
    end
    
    it "gathers the user's organization" do
      user1 = @s.users[0]
      expect(user1.organizations.count).to be == 1
    end
    it "gathers the user's submitted tickets" do
      user1 = @s.users[0]
      expect(user1.submitted_tickets.count).to be == 2
    end
    it "gathers the user's assigned tickets" do
      user1 = @s.users[0]
      expect(user1.assigned_tickets.count).to be == 2
    end
    it "gathers the ticket's two users" do
      ticket1 = @s.tickets[0]
      expect(ticket1.submitter.name).to eq("Elma Castro")
      expect(ticket1.assignee.name).to eq("Harris Côpeland")
    end
  end

  describe "#accept_commands" do
    it "quits when the user chooses quit" do
      allow(Readline).to receive(:readline).exactly(1).times.and_return('quit')
      expect{@s.accept_commands}.to output(/search options/).to_stdout
    end
    it "quits when the user chooses exit" do
      allow(Readline).to receive(:readline).exactly(1).times.and_return('exit')
      expect{@s.accept_commands}.to output(/search options/).to_stdout
    end
  end

  describe "#choose_dataset" do
    it "returns with an error if the user chooses an invalid option" do
      expect{@s.choose_dataset('4')}.to output(/Invalid/).to_stderr_from_any_process
    end

    it "returns an error and does no search if the search field is invalid" do
      allow(Readline).to receive(:readline).exactly(2).times.and_return('frog', '9999')
      allow(User).to receive(:display_searchable_fields)
      expect {@s.choose_dataset('1')}.to output(/Search term not found/).to_stderr_from_any_process
    end

    it "displays no results if a correct search term is entered with a nonexistent value" do
      allow(Readline).to receive(:readline).exactly(2).times.and_return('_id', '9999')
      expect {@s.choose_dataset('1')}.to output(/No Users Match/).to_stdout
    end

    it "displays results if a correct search term and value is entered" do
      allow(Readline).to receive(:readline).exactly(2).times.and_return('_id', '1')
      expect {@s.choose_dataset('1')}.to output(/Francisca Rasmussen/).to_stdout
    end
  end
end
