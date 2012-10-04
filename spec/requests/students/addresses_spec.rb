require 'spec_helper'

describe 'Address' do
  stub_authorization!
  
  before do
    @student = create(:student)
  end

  context 'new' do 
    before do 
      create(:country, :name => "Japan")
      visit student_path(@student)

      click_link 'new-student-address-tab-link'
      click_link 'new-student-address-link'
      wait_until { find("#new-student-address-form").visible? }
    end

    it 'should add and show student address', :js => true do
      !page.find("#new-student-address-link").visible?
      tr_count = page.all('table#student-addresses-index tr').size
      @student.addresses.size.should eql(0)
      #required
      select "Japan", :from => 'country_dropdown'
      fill_in "address_city", :with => "Nagoya"
      fill_in "address_address1", :with => "Subaru str."

      fill_in "address_title", :with => "John Doe main address"
      fill_in "address_zipcode", :with => "00359"
      fill_in "address_address2", :with => "Toyota str."

      click_button "submit-student-address-button"

      page.should have_selector('a', href: "/students/1/addresses/1/edit")
      #required
      page.should have_content("Japan")
      page.should have_content("Nagoya")
      page.should have_content("Subaru str.")
      
      page.should have_content("John Doe main address")
      page.should have_content("00359")
      page.should have_content("Toyota str.")
      page.all('table#student-addresses-index tr').size == tr_count + 1
      within('.student-addresses-count') { page.should have_content('Addresses list(1)') }
      within('#new-student-address-tab-link') { page.should have_content('Addresses(1)') }
      @student.addresses.size.should eql(1)
    end

    it 'should error if there are empty fields', :js => true do 
      page.should_not have_css('div.address_address1formError')
      click_button "submit-student-address-button"
      wait_until { page.should have_selector('div.address_address1formError') }
    end

    it 'should cancel adding address', :js => true do 
      click_link 'cancel-student-address-link'
      wait_until { !page.find("#new-student-address-form").visible? }
      find("#new-student-address-link").visible? 
    end
  end

  context 'edit and delete, set_primary' do 
    before(:each) do 
      @address = create(:address)
      create(:student_address, :student => @student, :address => @address)
      visit student_path(@student)
    end

    context 'edit' do
      before do 
        click_link 'new-student-address-tab-link'
        wait_until { page.has_content?('Addresses list') } 
        find(".edit-link").click 
        wait_until { find('#edit-address-modal').visible? }
      end

      it 'should edit a student address', :js => true do 
        fill_in 'address_address1', :with => 'Edited street address'
        fill_in 'address_city', :with => 'Tokyo'
        fill_in 'address_title', :with => 'Edited address'

        click_button 'submit-student-address-button'
        wait_until { !page.find('#edit-address-modal').visible? }

        page.should have_content('Edited street address')
        page.should have_content('Tokyo')
        page.should have_content('Edited address')
      end

      it 'should error if there are empty fields', :js => true do 
        fill_in 'address_address1', :with => ''
        fill_in 'address_city', :with => ''
        
        click_button 'submit-student-address-button'

        page.should have_content('Address1 can\'t be blank')
        page.should have_content('City can\'t be blank')
      end

      it 'should cancel editting', :js => true do 
        click_link 'cancel-student-address-link'
        wait_until { !page.find('#edit-address-modal').visible? }
      end
    end

    it 'should delete a student address', :js => true do
      click_link 'new-student-address-tab-link'
      tr_count = page.all('table#student-addresses-index tr').size
      within('#new-student-address-tab-link') { page.should have_content('Addresses(1)') }
      within('#new-student-address-tab-link') { page.should have_content('Addresses(1)') }
      page.should have_content(@address.address1)
      @student.addresses.size.should eql(0)
      @student.student_addresses.size.should eql(1)

      find(".delete-link").click 
      page.driver.browser.switch_to.alert.accept

      wait_until { page.all('table#student-addresses-index tr').size == tr_count - 1 } 
      within('.student-addresses-count') { page.should_not have_content('Addresses list(1)') }
      within('#new-student-address-tab-link') { page.should_not have_content('Addresses(1)') }
      page.should_not have_content(@address.address1)
      @student.student_addresses.size.should eql(0)
      @student.addresses.size.should eql(0)
      
    end

    it 'should set primary address', :js => true do 
      bulgaria = create(:country, :name => 'Bulgaria')
      @address2 = create(:address, :address1 => 'Maria Luiza blvd.', :city => 'Varna', :country => bulgaria)
      create(:student_address, :student => @student, :address => @address2)
    
      @student.student_addresses.first.is_primary? == true
      @student.student_addresses.second.is_primary? == false

      visit student_path(@student) 
      click_link 'new-student-address-tab-link'
      #wait_until { page.has_content?('Addresses list') } 

      within('table#student-addresses-index tr#address-2') { click_link 'set_primary_link' }

      @student.student_addresses.first.is_primary? == false
      @student.student_addresses.second.is_primary? == true
    end

  end
end