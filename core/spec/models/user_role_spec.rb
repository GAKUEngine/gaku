require 'spec_helper_models'

describe Gaku::UserRole, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :role }
  end
end
