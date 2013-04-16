require 'spec_helper'

describe Gaku::ExternalSchoolRecord do

  context "validations" do
    it { should belong_to :school }
    it { should belong_to :student }

    xit { should have_many :simple_grades }
    it { should have_many :achievements }

    it { should allow_mass_assignment_of :student_id }
    it { should allow_mass_assignment_of :school_id }
    it { should allow_mass_assignment_of :absences }
    it { should allow_mass_assignment_of :attendance_rate }
    it { should allow_mass_assignment_of :beginning }
    it { should allow_mass_assignment_of :ending }
    it { should allow_mass_assignment_of :graduated }
    it { should allow_mass_assignment_of :student_id_number }
    it { should allow_mass_assignment_of :data }

    it { should validate_presence_of :student_id }
    it { should validate_presence_of :school_id }
  end

end
