require 'spec_helper'

describe Gaku::CourseEnrollment do

  context "validations" do
    it { should belong_to(:course) }
    it { should belong_to(:student) }

    it { should validate_presence_of :course_id }
    
    it { should validate_uniqueness_of(:student_id).scoped_to(:course_id).with_message(/Already enrolled to course!/) }

    it { should allow_mass_assignment_of :course_id }
    it { should allow_mass_assignment_of :student_id }
  end
  
end
