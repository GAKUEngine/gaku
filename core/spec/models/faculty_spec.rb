require 'spec_helper_models'

describe Gaku::Faculty do

  describe 'concerns' do
    it_behaves_like 'contactable'
    it_behaves_like 'addressable'
  end

  describe 'associations' do
    it { should have_many :school_roles }
    it { should have_many :students }
    it { should have_many :class_groups }
    it { should have_many :courses }
  end

end
