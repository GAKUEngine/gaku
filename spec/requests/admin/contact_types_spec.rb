require 'spec_helper'

describe 'ContactTypes' do
  stub_authorization!

  context 'create and show' do
  	before do 
  	  visit admin_contact_types_path
    end

    it 'should create and show contact type', :js => true do 
      ContactType.count.should eql(0)
      click_link 'new_contact_type_link'

      wait_until { page.find('#js-new-contact-type-form').visible? }
      fill_in 'contact_type_name', :with => 'home phone'
      click_button 'submit_contact_type_button'

      wait_until { !page.find('#js-new-contact-type-form').visible? }
      page.should have_content('home phone')
      ContactType.count.should eql(1)
    end 
  end

  context 'index, edit and delete' do 
    before do
      @contact_type = Factory(:contact_type, :name => 'mobile') 
      visit admin_contact_types_path
    end

  	it 'should edit contact type', :js => true do
  	  within('table#contact_types_index tbody') { click_link('edit_contact_type_link') }
  	  
  	  wait_until { find('#editContactTypeModal').visible? } 
  	  fill_in 'contact_type_name', :with => 'email'
  	  click_button 'submit_contact_type_button' 

  	  wait_until { !page.find('#editContactTypeModal').visible? }
  	  page.should have_content('email')
  	  page.should_not have_content('mobile')
  	  ContactType.count.should eql(1)
  	end

  	it 'should delete contact type', :js => true do
      ContactType.count.should eql(1)
      tr_count = page.all('table#contact_types_index tr').size

      click_link('delete_contact_type_link') 
      page.driver.browser.switch_to.alert.accept
        
      wait_until { page.all('table#contact_types_index tr').size == tr_count - 1 }
      ContactType.count.should eql(0)
    end
  end

end