require 'spec_helper'

describe 'ClassGroup ClassGroupEnrollment' do
  before do
    sign_in_as!(Factory(:user))
    @class_group = Factory(:class_group, :grade => '1', :name => "Biology", :homeroom => 'A1')
    @student1 = Factory(:student)
    within('ul#menu') { click_link "Class Management" }
    within('ul#menu') { click_link "Class Listing" }
  end

  pending 'should add and show student to a class group', :js => true do
    click_link 'show_link'
    click_link 'class_group_enrollments_tab_link'
    page.should have_content "Class Roster"
    click_link 'add_class_group_enrollment'
    wait_until { page.find('#new_class_enrollment').visible? }
    check "#{@student1.id}"
    click_button 'submit_button'
    wait_until { !page.find('#new_class_enrollment').visible? }

    sleep 5 
  end

end
