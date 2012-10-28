require 'spec_helper'

describe CourseGroupEnrollment do

  context "validations" do 
  	it { should have_valid_factory(:course_group_enrollment) }
    it { should belong_to(:course_group) }
    it { should belong_to(:course) }

    it { should allow_mass_assignment_of :course_id }
    it { should allow_mass_assignment_of :course_group_id }
  end
  
end
