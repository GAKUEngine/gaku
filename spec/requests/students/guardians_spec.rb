require 'spec_helper'

describe 'Guardian' do
  
  before do
    @student = Factory(:student)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Students"}
  end

  it "should add and show student guardian", :js => true do
    visit student_path(@student)

    click_link 'new_student_guardian_tab_link'
    click_link 'new_student_guardian_link'

    wait_until { page.has_content?('Relationship') } 

    #required 
    fill_in "student_guardians_attributes_0_surname", :with => "Doe"
    fill_in "student_guardians_attributes_0_name", :with => "John"

    fill_in "student_guardians_attributes_0_surname_reading", :with => "Phonetic Doe"
    fill_in "student_guardians_attributes_0_name_reading", :with => "Phonetic John"
    fill_in "student_guardians_attributes_0_relationship", :with => "Father"

    click_button "Save Guardian"

    @student.guardians.size.should == 1
    page.should have_selector('a', href: "/students/1/guardians/1/edit")

    #required
    page.should have_content("Doe")
    page.should have_content("John")

    page.should have_content("Phonetic Doe")
    page.should have_content("Phonetic John")
    page.should have_content("Father")

  end
end