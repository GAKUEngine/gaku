require 'spec_helper_models'

describe Gaku::Specialty, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :student_specialties }
    it { is_expected.to have_many(:students).through(:student_specialties) }

    it { is_expected.to have_many(:program_specialties) }
    it { is_expected.to have_many(:programs).through(:program_specialties) }

    it { is_expected.to belong_to :department }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:specialty) { build(:specialty) }

    specify { specialty.to_s.should eq specialty.name }
  end
end
