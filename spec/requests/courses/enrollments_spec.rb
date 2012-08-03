require 'spec_helper'

describe "CourseEnrollments"  do
  before do
    @course = Factory(:course)
    @student = Factory(:student)
    @class_group = Factory(:class_group_enrollment)
    sign_in_as!(Factory(:user)) 
    within('ul#menu') do
      click_link "Course Management"
      click_link "Courses"
    end
  end

  it "should add and show student to a course", :js => true do
    visit course_path(@course)

    click_link 'Enrollment'
    click_link 'add_student_enrollment'
    wait_until { page.has_content?('Students') } 
    
    #required
    select @student.name, :from => 'course_enrollment_student_id'
    
    click_button "Enroll Student"
    wait_until { page.has_content?('View Assignments')}

    @course.course_enrollments.size.should == 1
    page.should have_content(@student.name)      
  end

end