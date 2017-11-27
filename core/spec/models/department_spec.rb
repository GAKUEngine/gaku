require 'spec_helper_models'

describe Gaku::Department, type: :model do

  describe 'associations' do
    it { should have_many :specialties }
    it { should have_many :syllabuses }
    it { should have_many :exams }

  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:department) { build(:department) }
    specify { department.to_s.should eq department.name }
  end

end
