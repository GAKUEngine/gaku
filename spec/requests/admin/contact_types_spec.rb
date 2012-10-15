require 'spec_helper'

describe 'ContactTypes' do
  stub_authorization!

  context 'create and show' do
  	before do 
  	  visit admin_contact_types_path
    end

    it 'should create and show contact type', :js => true do 
      tr_count = page.all('table#admin-contact-types-index tr').size
      ContactType.count.should eq 0
      click_link 'new-admin-contact-type-link'

      wait_until { page.find('#new-admin-contact-type form').visible? }
      !page.find('#new-admin-contact-type-link').visible?
      fill_in 'contact_type_name', :with => 'home phone'
      click_button 'submit-admin-contact-type-button'

      wait_until { !page.find('#new-admin-contact-type form').visible? }
      page.find('#new-admin-contact-type-link').visible?
      page.should have_content('home phone')
      page.all('table#admin-contact-types-index tr').size == tr_count + 1
      within('.admin-contact-types-count') { page.should have_content('Contact Types list(1)') }
      ContactType.count.should eq 1 
    end 

    it 'should cancel creating contact type', :js => true do 
      click_link 'new-admin-contact-type-link'

      wait_until { page.find('#cancel-admin-contact-type-link').visible? }
      click_link 'cancel-admin-contact-type-link'

      wait_until { !page.find('#new-admin-contact-type form').visible? }
      click_link 'new-admin-contact-type-link'
  
      wait_until { page.find('#new-admin-contact-type form').visible? }
    end
  end

  context 'index, edit and delete' do 
    before do
      @contact_type = create(:contact_type, :name => 'mobile') 
      visit admin_contact_types_path
    end

  	it 'should edit contact type', :js => true do
  	  within('table#admin-contact-types-index tbody') { find('.edit-link').click }
  	  
  	  wait_until { find('#edit-contact-type-modal').visible? } 
  	  fill_in 'contact_type_name', :with => 'email'
  	  click_button 'submit-admin-contact-type-button' 

  	  wait_until { !page.find('#edit-contact-type-modal').visible? }
  	  page.should have_content('email')
  	  page.should_not have_content('mobile')
  	  ContactType.count.should eq 1
  	end

    it 'should cancel editting', :js => true do 
      within('table#admin-contact-types-index tbody') { find('.edit-link').click }
      wait_until { find('#edit-contact-type-modal').visible? }

      click_link 'cancel-admin-contact-type-link'
      wait_until { !page.find('#edit-contact-type-modal').visible? }
    end


  	it 'should delete contact type', :js => true do
      ContactType.count.should eq 1
      within('.admin-contact-types-count') { page.should have_content('Contact Types list(1)') }
      tr_count = page.all('table#admin-contact-types-index tr').size

      find('.delete-link').click
      page.driver.browser.switch_to.alert.accept
        
      wait_until { page.all('table#admin-contact-types-index tr').size == tr_count - 1 }
      within('.admin-contact-types-count') { page.should_not have_content('Contact Types list(1)') }
      ContactType.count.should eq 0
    end
  end

end