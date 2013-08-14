require 'spec_helper'

describe Gaku::Country do

  describe 'associations' do
    it { should have_many :states }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :iso_name }
    it { should validate_presence_of :iso }
  end

  describe '#to_s' do
    let(:country) { build(:country) }
    specify { country.to_s.should eq country.name }
  end

end
