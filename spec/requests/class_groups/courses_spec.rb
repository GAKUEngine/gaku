require 'spec_helper'

describe 'ClassGroup Courses' do
  stub_authorization!
  
  before do
    @class_group = Factory(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
    #within('ul#menu') { click_link "Class Management" }
    #within('ul#menu') { click_link "Class Listing" }
    @course = Factory(:course)
    visit class_group_path(@class_group)
    click_link 'class_group_courses_tab_link'
  end

  it 'should add and show course to a class group', :js => true do
    
    click_link 'add_class_group_course_link'
    wait_until { page.find('#add_class_group_course').visible? }
    select "#{@course.code}", :from => 'class_group_course_enrollment_course_id'
    click_button 'submit_button'

    page.should have_content ("#{@course.code}")
    visit class_group_path(@class_group)
    click_link 'class_group_courses_tab_link'
    within('.tab-content') { page.should have_content "#{@course.code}"}
  end
  pending 'should not add a course if course code is empty', :js => true do #FIXME cannot load the validation code properly
    
    click_link 'show_course_form'
    wait_until { page.find('#add_class_group_course').visible? }
    click_button 'submit_button'

    wait_until { page.has_content?('This field is required') }
  end

  context 'Class group with added course' do
    pending 'should not add a course if it is already added' do  #need to be implemented in the main logic
    end
    pending 'should delete a course from class group' do  #need to be implemented in the main logic
    end
  end
end
