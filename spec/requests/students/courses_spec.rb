require 'spec_helper'

describe 'Course' do
  
  before do
    @student = Factory(:student)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Students" }
  end

  it "should add and show student course", :js => true do
    Factory(:course, :code => "fall2012" )
    visit student_path(@student) 

    click_link 'new_student_course_tab_link'
    click_link 'new_student_course_link'

    wait_until { page.has_content?('New Course') } 

    select "fall2012", :from => 'course_enrollment_course_id'

    click_button "Create enrollment"

    #@student.courses.size.should == 1

    page.should have_content("fall2012")

  end
end