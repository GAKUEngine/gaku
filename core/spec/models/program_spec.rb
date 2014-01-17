require 'spec_helper_models'

describe Gaku::Program do

  describe 'associations' do
    it { should have_many :program_levels }
    it { should have_many(:levels).through(:program_levels) }

    it { should have_many :program_specialties }
    it { should have_many(:specialties).through(:program_specialties) }

    it { should have_many :program_syllabuses }
    it { should have_many(:syllabuses).through(:program_syllabuses) }

    it { should belong_to :school }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :school }
  end

  describe 'nested_attributes' do
    it { should accept_nested_attributes_for :program_levels }
    it { should accept_nested_attributes_for :program_specialties }
    it { should accept_nested_attributes_for :program_syllabuses }
  end

  describe '#to_s' do
    let(:program) { build(:program) }
    specify { program.to_s.should eq program.name }
  end

end
