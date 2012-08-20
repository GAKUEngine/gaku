require 'spec_helper'

describe 'Course' do
  
  before do
    @student = Factory(:student)
    @course = Factory(:course, :code => 'fall2050')
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Students" }
  end

  it "should add and show student course", :js => true do
    visit student_path(@student) 

    click_link 'new_student_course_tab_link'
    click_link 'new_student_course_link'

    wait_until { page.has_content?('New Course') } 

    select "fall2050", :from => 'course_enrollment_course_id'
    click_button "Create enrollment"

    page.should have_content("fall2050")
    #@student.courses.size.should == 1
  end

  it "should delete a student course", :js => true do
    
    @student.courses << @course
    #Factory(:course_enrollment, :course => @course, :student => @dtudent)

    visit student_path(@student) 
    click_link 'new_student_course_tab_link'
    wait_until { page.has_content?('Courses List') }
    #page.all('table.index tr').size.should == 2
    page.should have_content(@course.code)
    @student.courses.size.should == 1

    click_link 'delete_link' 
    page.driver.browser.switch_to.alert.accept
    #FIXME Make a real check, no sleep 
    sleep 1
    #page.all('table.index tr').size.should == 2
    @student.courses.size.should == 0
    page.should_not have_content(@course.code)
  end
  
end