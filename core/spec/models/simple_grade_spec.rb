require 'spec_helper'

describe Gaku::SimpleGrade do

  context "validations" do
  	it { should belong_to :school }
  	it { should belong_to :student }

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :grade }
    it { should allow_mass_assignment_of :school_id }
    it { should allow_mass_assignment_of :student_id }

    it { should validate_presence_of :school_id }
    it { should validate_presence_of :student_id }

  end
end
