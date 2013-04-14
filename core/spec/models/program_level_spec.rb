require 'spec_helper'
  describe Gaku::ProgramLevel do

  context "validation" do

    it { should belong_to :program }
    it { should belong_to :level }

    it { should allow_mass_assignment_of :program_id }
    it { should allow_mass_assignment_of :level_id }
  end

end
