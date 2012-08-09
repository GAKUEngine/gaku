# == Schema Information
#
# Table name: course_enrollments
#
#  id         :integer          not null, primary key
#  student_id :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe CourseEnrollment do

  context "validations" do 
    it { should have_valid_factory(:course_enrollment) }
    it { should belong_to(:course) }
    it { should belong_to(:student) }
  end
  
end
