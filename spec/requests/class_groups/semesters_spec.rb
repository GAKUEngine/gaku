require 'spec_helper'

describe 'ClassGroup Semesters' do
  before do
    sign_in_as!(Factory(:user))
    @class_group = Factory(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
    within('ul#menu') { click_link "Class Management" }
    within('ul#menu') { click_link "Class Listing" }
    visit class_group_path(@class_group)
  end

  it 'should add and show semester to a class group', :js => true do
    click_link 'class_group_semesters_tab_link'
    page.should have_content "Semesters list"
    click_link 'show_semester_form'
    wait_until { page.find('#semester_form').visible? }

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
