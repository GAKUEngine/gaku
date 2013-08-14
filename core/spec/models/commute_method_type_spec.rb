require 'spec_helper'

describe Gaku::CommuteMethodType do

  describe 'associations' do
    it { should have_many :students }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:commute_method_type) { build(:commute_method_type) }
    specify { commute_method_type.to_s.should eq commute_method_type.name }
  end

end
