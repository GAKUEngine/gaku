require 'spec_helper'
  describe Gaku::ProgramSpecialty do

  context "validation" do
    it { should belong_to :program }
    it { should belong_to :specialty }

    it { should allow_mass_assignment_of :program_id }
    it { should allow_mass_assignment_of :specialty_id }

    it { should validate_presence_of :specialty_id }
  end
end
