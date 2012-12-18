require 'spec_helper'

describe Gaku::CourseGroupEnrollment do

  context "validations" do 
    it { should belong_to(:course_group) }
    it { should belong_to(:course) }

    it { should allow_mass_assignment_of :course_id }
    it { should allow_mass_assignment_of :course_group_id }

    it { should validate_presence_of :course_group_id }
    it { should validate_presence_of :course_id }

    it { should validate_uniqueness_of(:course_id).scoped_to(:course_group_id).with_message(/already enrolled to this course group!/) }


  end
  
end
