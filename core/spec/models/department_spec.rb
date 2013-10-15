require 'spec_helper'

describe Gaku::Department do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:department) { build(:department) }
    specify { department.to_s.should eq department.name }
  end

end
