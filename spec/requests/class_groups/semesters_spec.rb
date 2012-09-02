require 'spec_helper'

describe 'ClassGroup Semesters' do
  before do
    sign_in_as!(Factory(:user))
    @class_group = Factory(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
    within('ul#menu') { click_link "Class Management" }
    within('ul#menu') { click_link "Class Listing" }
    visit class_group_path(@class_group)
    click_link 'class_group_semesters_tab_link'
  end

  it 'should add and show semester to a class group', :js => true do
    
    page.should have_content "Semesters list"
    click_link 'add_class_group_semester_link'
    wait_until { page.find('#add_class_group_semester').visible? }
    #select a semester
    select '2012', :from => 'semester_starting_1i'
    select 'September', :from => 'semester_starting_2i'
    select '28', :from => 'semester_starting_3i'

    select '2012', :from => 'semester_ending_1i'
    select 'December', :from => 'semester_ending_2i'
    select '20', :from => 'semester_ending_3i'
    click_button 'submit_button'
    wait_until { !page.find('#add_class_group_semester').visible? }

    page.should have_content('09/28/2012 - 12/20/2012')
    @class_group.semesters.count.should == 1
  end
  context 'Class group with added semester' do
    pending 'should not add a semester if it is already added' do #need to be implemeted in the main logic
    end
    pending 'should delete a semester from class group' do #need to be implemented in the main logic
    end
  end

end