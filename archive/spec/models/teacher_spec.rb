require 'spec_helper_models'

describe Gaku::Teacher do

  describe 'concerns' do
    it_behaves_like 'thrashable'
  end

end
