require 'spec_helper_models'

describe Gaku::Department, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :specialties }
    it { is_expected.to have_many :syllabuses }
    it { is_expected.to have_many :exams }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:department) { build(:department) }

    specify { department.to_s.should eq department.name }
  end
end
