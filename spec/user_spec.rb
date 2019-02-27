require 'user'
require 'search'

RSpec.describe User do

  describe '#find' do
    it 'returns an error if the search term is not found' do
      expect { User.find('fake', 1, []) }.to output(a_string_including("Search term not found")).to_stderr_from_any_process
    end
  end
end
