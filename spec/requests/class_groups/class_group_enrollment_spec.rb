require 'spec_helper'

describe 'ClassGroup ClassGroupEnrollment' do
  before do
    sign_in_as!(Factory(:user))
    @class_group = Factory(:class_group, :grade => '1', :name => "Biology", :homeroom => 'A1')
    @student1 = Factory(:student)
    within('ul#menu') { click_link "Class Management" }
    within('ul#menu') { click_link "Class Listing" }
  end

  it 'should add and show student to a class group', :js => true do
    click_link 'show_link'
    click_link 'class_group_enrollments_tab_link'
    page.should have_content "Class Roster"
    click_link 'add_class_group_enrollment'
    wait_until { page.find('#new_class_enrollment').visible? }
    check "#{@student1.id}"
    click_button 'submit_button'
    wait_until { !page.find('#new_class_enrollment').visible? }

    sleep 5 

    select '2012', :from => 'semester_starting_1i'
    select 'January', :from => 'semester_starting_2i'
    select '7', :from => 'semester_starting_3i'

    select '2012', :from => 'semester_ending_1i'
    select 'June', :from => 'semester_ending_2i'
    select '7', :from => 'semester_ending_3i'

    click_button 'submit_button'
    page.should have_content('01/07/2012 - 06/07/2012')
    wait_until { !page.find('#semester_form').visible? }
    @class_group.semesters.count.should == 1
  end

end
