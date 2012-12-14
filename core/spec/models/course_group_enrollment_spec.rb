require 'spec_helper'

describe Gaku::CourseGroupEnrollment do

  context "validations" do 
    it { should belong_to(:course_group) }
    it { should belong_to(:course) }

    it { should allow_mass_assignment_of :course_id }
    it { should allow_mass_assignment_of :course_group_id }
  end
  
end
