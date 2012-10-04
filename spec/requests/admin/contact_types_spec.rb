require 'spec_helper'

describe 'ContactTypes' do
  stub_authorization!

  context 'create and show' do
  	before do 
  	  visit admin_contact_types_path
    end

    it 'should create and show contact type', :js => true do 
      ContactType.count.should eql(0)
      click_link 'new-contact-type-link'

      wait_until { page.find('#new-contact-type-form').visible? }
      !page.find('#new-contact-type-link').visible?
      fill_in 'contact_type_name', :with => 'home phone'
      click_button 'submit-contact-type-button'

      wait_until { !page.find('#new-contact-type-form').visible? }
      page.find('#new-contact-type-link').visible?
      page.should have_content('home phone')
      ContactType.count.should eql(1)
    end 

    it 'should cancel creating contact type', :js => true do 
    	ContactType.count.should eql(0)
      click_link 'new-contact-type-link'

      wait_until { page.find('#new-contact-type-form').visible? }
      click_link 'cancel-contact-type-link'

      wait_until { !page.find('#new-contact-type-form').visible? }
      ContactType.count.should eql(0)
    end
  end

  context 'index, edit and delete' do 
    before do
      @contact_type = create(:contact_type, :name => 'mobile') 
      visit admin_contact_types_path
    end

  	it 'should edit contact type', :js => true do
  	  within('table#contact-types-index tbody') { click_link('edit-contact-type-link') }
  	  
  	  wait_until { find('#edit-contact-type-modal').visible? } 
  	  fill_in 'contact_type_name', :with => 'email'
  	  click_button 'submit-contact-type-button' 

  	  wait_until { !page.find('#edit-contact-type-modal').visible? }
  	  page.should have_content('email')
  	  page.should_not have_content('mobile')
  	  ContactType.count.should eql(1)
  	end

  	it 'should delete contact type', :js => true do
      ContactType.count.should eql(1)
      tr_count = page.all('table#contact-types-index tr').size

      click_link('delete-contact-type-link') 
      page.driver.browser.switch_to.alert.accept
        
      wait_until { page.all('table#contact-types-index tr').size == tr_count - 1 }
      ContactType.count.should eql(0)
    end
  end

end