require 'spec_helper'

describe 'ClassGroup Courses' do
  before do
    sign_in_as!(Factory(:user))
    @class_group = Factory(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
    within('ul#menu') { click_link "Class Management" }
    within('ul#menu') { click_link "Class Listing" }
    visit class_group_path(@class_group)
  end

  it 'should add and show course to a class group', :js => true do
    
    click_link 'class_group_courses_tab_link'
    page.should have_content "Courses List"
    click_link 'show_course_form'
    wait_until { page.has_content?('Course Code') }

    fill_in 'course_code', :with => 'course#1'

    click_button 'submit_button'
    
    page.should have_content('was successfully created')
    page.should have_content('course#1')
    #TODO Make more checks
  end

end
