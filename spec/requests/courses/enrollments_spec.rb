require 'spec_helper'

describe "CourseEnrollment"  do
  before do
    @course = Factory(:course)
    @student = Factory(:student)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Courses"}
  end
  it "should add and show student course", :js => true do
    visit course_path(@course)

    click_link 'Enrollment'
    click_link 'new_student_enrollment_link'

    wait_until { page.has_content?('Enroll Student') } 
    #required
    select student.name, :from => 'course_enrollment_student_id'
   
    click_button "Enroll Student"

    @course.course_enrollments.size.should == 1
    
    #required
    page.should have_content(@student.name)      
  end
end