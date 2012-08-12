# == Schema Information
#
# Table name: courses
#
#  id             :integer          not null, primary key
#  code           :string(255)
#  faculty_id     :integer
#  syllabus_id    :integer
#  class_group_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Course do

  context "validations" do 
  	it { should have_valid_factory(:course) }
    it { should have_many(:students) }
    it { should have_many(:course_enrollments) }
    it { should have_many(:exam_schedules) }
    it { should belong_to(:syllabus) }
    it { should belong_to(:class_group) }
  end
  
  context "enroll_class_group" do
  	it "should enroll class group to course" do
			course = Factory(:course)
			student1, student2 = Factory(:student), Factory(:student, :name => 'gaku') 
      class_group = Factory(:class_group)
      Factory(:class_group_enrollment, :student_id => student1.id, :class_group_id => class_group.id)
      Factory(:class_group_enrollment, :student_id => student2.id, :class_group_id => class_group.id)
  		course.enroll_class_group(class_group)
  		course.student_ids.include?(student1.id)
  		course.student_ids.include?(student2.id)
  	end
    
  end

end
