RSpec.describe Record do

  describe '#find' do
    it 'returns an error if the search term is not found' do
      Record.expected_fields = [ :_id, :name ]
      expect { Record.find_and_display('fake', 1, []) }.to output(/Search term not found/).to_stderr_from_any_process
    end
    
    it 'does not return a search term error if the search term is found' do
      Record.expected_fields = [ :_id, :name ]
      allow(Search).to receive(:error).with(/No  Match/)
      expect { Record.find_and_display('name', 1, []) }.to_not output(/Search term not found/).to_stderr_from_any_process
    end
  end

end
