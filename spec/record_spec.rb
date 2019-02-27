RSpec.describe Record do

  describe '#find' do
    it 'returns an error if the search term is not found' do
      Record.expected_fields = [ :_id, :name ]
      expect { Record.find('fake', 1, []) }.to output(a_string_including("Search term not found")).to_stderr_from_any_process
    end
    
    it 'does not return an error if the search term is found' do
      Record.expected_fields = [ :_id, :name ]
      expect { Record.find('name', 1, []) }.to_not output(a_string_including("Search term not found")).to_stderr_from_any_process
    end
  end

end
