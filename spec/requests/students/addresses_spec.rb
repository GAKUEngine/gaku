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
    fill_in "address_city", :with => "Nagoya"
    fill_in "address_address1", :with => "Subaru str."

    fill_in "address_title", :with => "John Doe main address"
    fill_in "address_zipcode", :with => "00359"
    fill_in "address_address2", :with => "Toyota str."

    click_button "Save address"

    page.should have_selector('a', href: "/students/1/addresses/1/edit")

    #required
    page.should have_content("Japan")
    page.should have_content("Nagoya")
    page.should have_content("Subaru str.")
    
    page.should have_content("John Doe main address")
    page.should have_content("00359")
    page.should have_content("Toyota str.")
    #page.should have_content("Aichi")
    @student.addresses.size.should == 1
    
  end

  context "edit and delete" do 

    before(:each) do 
      @address = Factory(:address)
      Factory(:student_address, :student => @student, :address => @address)
      visit student_path(@student) 
      click_link 'new_student_address_tab_link'
      wait_until { page.has_content?('Addresses list') } 
    end

    it "should edit a student address", :js => true do 
      click_link "edit_link" 
      wait_until { find('#editAddressModal').visible? } 

      fill_in 'address_address1', :with => 'Edited street address'
      fill_in 'address_city', :with => 'Tokyo'
      fill_in 'address_title', :with => 'Edited address'

      click_button 'submit_button'
      wait_until { !page.find('#editAddressModal').visible? }

      page.should have_content('Edited street address')
      page.should have_content('Tokyo')
      page.should have_content('Edited address')
    end

    it "should delete a student address", :js => true do
      page.all('table.index tr').size.should == 3
      page.should have_content(@address.address1)
      #@student.addresses.size.should == 1

      click_link "delete_link" 
      page.driver.browser.switch_to.alert.accept
      #FIXME Make a real check, no sleep 
      sleep 1
      page.all('table.index tr').size.should == 2
      @student.addresses.size.should == 0
      page.should_not have_content(@address.address1)
    end

  end
end