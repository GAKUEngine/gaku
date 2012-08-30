require 'spec_helper'

describe 'Guardian Addresses' do

  before(:each) do
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Students" }

    @student = Factory(:student)
    @guardian = Factory(:guardian)
    @student.guardians << @guardian
    @student.reload
    @country = Factory(:country, :name => "Japan")

    visit student_path(@student) 
    click_link 'new_student_guardian_tab_link'
    wait_until { page.has_content?('Guardians List') } 
  end

  it "should add and show address to a student guardian", :js => true do 
    @student.guardians.first.addresses.count.should == 0

    click_link 'show_link' 
    click_link 'add_student_guardian_address_link'
    wait_until { page.has_content?('New Address') }

    select 'Japan', :from => 'country_dropdown'
    fill_in 'address_address1', :with => 'Subaru str.'
    fill_in 'address_city', :with => 'Nagoya'

    click_button 'submit_button'

    page.should have_content('Japan')
    page.should have_content('Nagoya')
    page.should have_content('Subaru str.')
    @student.guardians.first.addresses.count.should == 1
  end

  context 'edit, delete, set primary' do 
    before do 
      bulgaria = Factory(:country, :name => "Bulgaria")
      address1 = Factory(:address, :address1 => 'Toyota str.', :country => @country, :city => 'Nagoya')
      address2 = Factory(:address, :address1 => 'Maria Luiza bul.', :country => bulgaria, :city => 'Varna')
      @student.guardians.first.addresses << [ address1, address2 ]
      @student.reload
      click_link 'show_link'
    end

    it 'should edit address for student guardian', :js => true do 
      Factory(:country, :name => "Brasil")
      #page.should have_content 'Bulgaria'

      within('table.guardian_address_table tr#address_2') { click_link 'edit_link' }
      wait_until { find('#editAddressModal').visible? }

      select 'Brasil', :from => 'country_dropdown'
      fill_in 'address_address1', :with => 'Rio str.'
      fill_in 'address_city', :with => 'Brasilia'

      click_button 'submit_button'

      page.should have_content 'Brasil'
      #page.should_not have_content 'Bulgaria'
    end

    it 'should delete address for student guardian', :js => true do 
      tr_count = page.all('table.index tr').size
      page.should have_content('Bulgaria')
      @student.guardians.first.addresses.size.should == 2

      within('table.guardian_address_table tr#address_2') { click_link 'delete_link' }
      page.driver.browser.switch_to.alert.accept

      wait_until { page.all('table.index tr').size == tr_count - 1 } 
      @student.guardians.first.addresses.size.should == 1
      page.should_not have_content('Bulgaria')
    end

 
    it 'should set primary address for student guardian', :js => true do 
      #TODO Maybe refactor so to call addresses instead of guardian_addresses
      @student.guardians.first.guardian_addresses.first.is_primary? == true
      @student.guardians.first.guardian_addresses.second.is_primary? == false

      within('table.guardian_address_table tr#address_2') { click_link 'set_primary_link' }
      #page.driver.browser.switch_to.alert.accept

      @student.guardians.first.guardian_addresses.first.is_primary? == false
      @student.guardians.first.guardian_addresses.second.is_primary? == true
    end
  end
  
end