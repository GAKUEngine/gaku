require 'spec_helper'

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
  end

end
