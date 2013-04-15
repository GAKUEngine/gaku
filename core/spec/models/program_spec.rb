require 'spec_helper'
  describe Gaku::Program do

  context "validation" do

    it { should have_many :program_levels }
    it { should have_many(:levels).through(:program_levels) }

    it { should have_many :program_specialties }
    it { should have_many(:specialties).through(:program_specialties) }

    it { should have_many :syllabuses }

    it { should belong_to :school }

    it { should validate_presence_of :name }

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :description }
  end
end
