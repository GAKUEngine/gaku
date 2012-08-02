require 'spec_helper'

describe 'Address' do
  
  before do
    @student = Factory(:student)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Students"}
  end

  it "should allow to add a student address", :js => true do
    Factory(:country, :name => "Japan")
    visit student_path(@student)

    click_link 'new_student_address_tab_link'
    click_link 'new_student_address_link'

    wait_until { page.has_content?('Country') } 
    #required
    select "Japan", :from => 'country_dropdown'
    fill_in "student_addresses_attributes_0_city", :with => "Nagoya"
    fill_in "student_addresses_attributes_0_address1", :with => "Subaru str."

    fill_in "student_addresses_attributes_0_title", :with => "John Doe main address"
    fill_in "student_addresses_attributes_0_zipcode", :with => "00359"
    fill_in "student_addresses_attributes_0_address2", :with => "Toyota str."
    #fill_in "student_addresses_attributes_0_state", :with => "Aichi"
   

    click_button "Save address"

    @student.addresses.size.should == 1
    page.should have_selector('a', href: "/students/1/addresses/1/edit")

    #required
    page.should have_content("Japan")
    page.should have_content("Nagoya")
    page.should have_content("Subaru str.")
    
    page.should have_content("John Doe main address")
    page.should have_content("00359")
    page.should have_content("Toyota str.")
    #page.should have_content("Aichi")
    
  end
end