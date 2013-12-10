require 'spec_helper_models'

describe Gaku::StudentGuardian do

  describe 'associations' do
    it { should belong_to :student }
    it { should belong_to :guardian }
  end

end
