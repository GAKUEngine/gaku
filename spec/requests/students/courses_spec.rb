require 'spec_helper'

describe 'Course' do
  stub_authorization!
  
  before do
    @student = Factory(:student)
    @course = Factory(:course, :code => 'fall2050')
    visit student_path(@student) 
  end

  it "should add and show student course", :js => true do
    click_link 'new_student_course_tab_link'
    click_link 'new_student_course_link'

    wait_until { page.has_content?('New Course') } 

    select "fall2050", :from => 'course_enrollment_course_id'
    click_button "Create enrollment"
    
    sleep 1
    page.should have_content("fall2050")
    @student.courses.size.should eql(1)
  end

  it "should delete a student course", :js => true do
    @student.courses << @course

    visit student_path(@student) 
    click_link 'new_student_course_tab_link'
    wait_until { page.has_content?('Courses List') }

    tr_count = page.all('table.index tr').size
    page.should have_content(@course.code)
    @student.courses.size.should eql(1)

    click_link 'delete_link' 
    page.driver.browser.switch_to.alert.accept

    wait_until { page.all('table.index tr').size == tr_count - 1 }
    @student.courses.size.should eql(0)
    page.should_not have_content(@course.code)
  end
  
end