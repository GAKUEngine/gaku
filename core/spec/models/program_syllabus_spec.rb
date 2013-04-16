require 'spec_helper'

describe Gaku::ProgramSyllabus do

  context "validations" do
    it { should belong_to :program }
    it { should belong_to :syllabus }
    it { should belong_to :level }

    it { should allow_mass_assignment_of :program_id}
    it { should allow_mass_assignment_of :syllabus_id }
    it { should allow_mass_assignment_of :level_id }
  end
end
