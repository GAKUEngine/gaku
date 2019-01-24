require 'spec_helper_models'

describe Gaku::StudentGuardian, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :student }
    it { is_expected.to belong_to :guardian }
  end
end
