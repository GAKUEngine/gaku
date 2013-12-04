require 'spec_helper_models'

describe Gaku::Exam do

  let!(:exam) { create(:exam) }

  describe 'concerns' do
    it_behaves_like 'thrashable'
  end

end
