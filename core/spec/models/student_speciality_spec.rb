require 'spec_helper'

describe Gaku::StudentSpecialty do

  context "validations" do
    it { should belong_to :specialty }
    it { should belong_to :student }

    it { should allow_mass_assignment_of :student_id }
    it { should allow_mass_assignment_of :specialty_id }
    it { should allow_mass_assignment_of :is_major }

    it { should validate_presence_of :student_id }
    it { should validate_presence_of :specialty_id }
  end
end
