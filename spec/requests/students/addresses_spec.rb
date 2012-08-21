require 'spec_helper'

describe 'Address' do
  
  before do
    @student = Factory(:student)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Students"}
  end
  context 'add' do 

    before do 
      Factory(:country, :name => "Japan")
      visit student_path(@student)

      click_link 'new_student_address_tab_link'
      click_link 'new_student_address_link'
      wait_until { page.has_content?('Country') }
    end

    it 'should add and show student address', :js => true do
       
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

    it 'should error if there are empty fields', :js => true do 
      click_button "Save address"
      page.should have_content('Address1 is empty')
      page.should have_content('City is empty')
    end
  end

  context 'edit and delete, set_primary' do 

    before(:each) do 
      @address = Factory(:address)
      Factory(:student_address, :student => @student, :address => @address)
      visit student_path(@student)
    end

    context 'edit' do

      before do 
        click_link 'new_student_address_tab_link'
        wait_until { page.has_content?('Addresses list') } 
        click_link "edit_link" 
        wait_until { find('#editAddressModal').visible? }
      end

      it 'should edit a student address', :js => true do 
        fill_in 'address_address1', :with => 'Edited street address'
        fill_in 'address_city', :with => 'Tokyo'
        fill_in 'address_title', :with => 'Edited address'

        click_button 'submit_button'
        wait_until { !page.find('#editAddressModal').visible? }

        page.should have_content('Edited street address')
        page.should have_content('Tokyo')
        page.should have_content('Edited address')
      end

      it 'should error if there are empty fields', :js => true do 
        fill_in 'address_address1', :with => ''
        fill_in 'address_city', :with => ''
        
        click_button 'submit_button'

        page.should have_content('Address1 is empty')
        page.should have_content('City is empty')
      end
    end

    it 'should delete a student address', :js => true do
      click_link 'new_student_address_tab_link'
      wait_until { page.has_content?('Addresses list') } 
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

    it 'should set primary address', :js => true do 
      bulgaria = Factory(:country, :name => 'Bulgaria')
      @address2 = Factory(:address, :address1 => 'Maria Luiza blvd.', :city => 'Varna', :country => bulgaria)
      Factory(:student_address, :student => @student, :address => @address2)
    
      #TODO Maybe refactor so to call addresses instead of student_addresses
      @student.student_addresses.first.is_primary? == true
      @student.student_addresses.second.is_primary? == false

      visit student_path(@student) 
      click_link 'new_student_address_tab_link'
      wait_until { page.has_content?('Addresses list') } 

      within('table.index tr#address_2') { click_link 'set_primary_link' }

      @student.student_addresses.first.is_primary? == false
      @student.student_addresses.second.is_primary? == true
    end

  end
end