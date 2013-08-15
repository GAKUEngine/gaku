require 'spec_helper'

describe Gaku::ScholarshipStatus do

  describe 'associations' do
    it { should have_many :students }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:scholarship_status) { build(:scholarship_status) }
    specify { scholarship_status.to_s.should eq scholarship_status.name }
  end

end
