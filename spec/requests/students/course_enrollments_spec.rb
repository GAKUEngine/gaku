require 'spec_helper'

describe 'CourseEnrollments' do
  stub_authorization!
  
  before do
    @student = Factory(:student)
    @course = Factory(:course, :code => 'fall2050')
    visit student_path(@student) 
  end

  it "should add and show student course", :js => true do\
    @student.courses.size.should eql(0)
    click_link 'new-student-course-enrollment-tab-link'
    click_link 'new-student-course-enrollment-link'

    wait_until { find('#new-student-course-enrollment-form').visible? } 

    select "fall2050", :from => 'course_enrollment_course_id'
    click_button "submit-student-course-enrollment-button"
    
    wait_until { !page.find('#new-student-course-enrollment-form').visible? } 
    page.should have_content("fall2050")
    @student.courses.size.should eql(1)
  end

  it "should delete a student course", :js => true do
    @student.courses << @course

    visit student_path(@student) 
    click_link 'new-student-course-enrollment-tab-link'
    wait_until { page.has_content?('Courses List') }

    tr_count = page.all('table#student-course-enrollments-index tr').size
    page.should have_content(@course.code)
    @student.courses.size.should eql(1)

    click_link 'delete-student-course-enrollment-link' 
    page.driver.browser.switch_to.alert.accept

    wait_until { page.all('table#student-course-enrollments-index tr').size == tr_count - 1 }
    @student.courses.size.should eql(0)
    page.should_not have_content(@course.code)
  end
  
end