require 'spec_helper_models'

describe Gaku::Role, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :user_roles }
    it { is_expected.to have_many(:users).through(:user_roles) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe '#to_s' do
    let(:role) { build(:role) }

    specify { role.to_s.should eq role.name }
  end
end
