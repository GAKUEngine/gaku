require 'spec_helper_models'

describe Gaku::Faculty, type: :model do
  describe 'concerns' do
    it_behaves_like 'contactable'
    it_behaves_like 'addressable'
  end

  describe 'associations' do
    it { is_expected.to have_many :school_roles }
    it { is_expected.to have_many :students }
    it { is_expected.to have_many :class_groups }
    it { is_expected.to have_many :courses }
  end
end
