require 'spec_helper'

describe Gaku::Role do

  describe 'associations' do
    it { should have_many :user_roles }
    it { should have_many(:users).through(:user_roles) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:role) { build(:role) }
    specify { role.to_s.should eq role.name }
  end

end
