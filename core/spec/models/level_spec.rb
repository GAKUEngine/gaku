require 'spec_helper'
  describe Gaku::Level do

  context "validation" do
    it { should have_many :program_levels }
    it { should have_many(:programs).through(:program_levels) }

    it { should belong_to :school }
    it { should validate_presence_of :name }

    it { should allow_mass_assignment_of :name }
  end
end
