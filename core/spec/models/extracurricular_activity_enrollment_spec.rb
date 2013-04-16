require 'spec_helper'

describe Gaku::ExtracurricularActivityEnrollment do

  context "validations" do
    it { should belong_to :extracurricular_activity }
    it { should belong_to :student }
    it { should have_many :roles }

    it { should validate_presence_of :extracurricular_activity_id }
    it { should validate_presence_of :student_id }

    it { should validate_uniqueness_of(:student_id).scoped_to(:extracurricular_activity_id).with_message(/Already enrolled to the extracurricular activity!/) }

    it { should allow_mass_assignment_of :extracurricular_activity_id }
    it { should allow_mass_assignment_of :student_id }
  end

end
