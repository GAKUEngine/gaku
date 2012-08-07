require 'spec_helper'

describe 'Contact' do
  
  before do
    @student = Factory(:student)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Students" }
  end

  it "should add and show student contact", :js => true do
    visit student_path(@student) 

    click_link 'new_student_contact_tab_link'
    click_link 'new_student_contact_link'

    wait_until { page.has_content?('New Contact') } 

    fill_in "contact_data", :with => "The contact data"
    fill_in "contact_details", :with => "The contact details"

    click_button "Save Contact"

    @student.contacts.size.should == 1
    page.should have_selector('a', href: "/students/1/contacts/1/edit")

    page.should have_content("The contact data")
    page.should have_content("The contact details")

  end
end