require 'spec_helper'

describe Course do

  context "validations" do 
  	it { should have_valid_factory(:course) }
    it { should have_many(:course_enrollments) }
    it { should have_many(:students) }
    it { should have_many(:course_group_enrollments) }
    it { should have_many(:course_groups) }
    it { should have_many(:exam_schedules) }
    it { should belong_to(:syllabus) }
    it { should have_many(:class_groups) }
    it { should have_many(:class_group_course_enrollments) }
  end
  
  context "enroll_class_group" do
  	it "should enroll class group to course" do
			course = create(:course)
			student1, student2 = create(:student), create(:student, :name => 'gaku') 
      class_group = create(:class_group)
      create(:class_group_enrollment, :student_id => student1.id, :class_group_id => class_group.id)
      create(:class_group_enrollment, :student_id => student2.id, :class_group_id => class_group.id)
  		course.enroll_class_group(class_group)
  		course.student_ids.include?(student1.id)
  		course.student_ids.include?(student2.id)
  	end
    
  end

end
