require 'spec_helper_models'

describe Gaku::Program, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :program_levels }
    it { is_expected.to have_many(:levels).through(:program_levels) }

    it { is_expected.to have_many :program_specialties }
    it { is_expected.to have_many(:specialties).through(:program_specialties) }

    it { is_expected.to have_many :program_syllabuses }
    it { is_expected.to have_many(:syllabuses).through(:program_syllabuses) }

    it { is_expected.to belong_to :school }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to validate_presence_of :school }
  end

  describe 'nested_attributes' do
    it { is_expected.to accept_nested_attributes_for :program_levels }
    it { is_expected.to accept_nested_attributes_for :program_specialties }
    it { is_expected.to accept_nested_attributes_for :program_syllabuses }
  end

  describe '#to_s' do
    let(:program) { build(:program) }

    specify { program.to_s.should eq program.name }
  end
end
