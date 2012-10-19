require 'spec_helper'

describe 'ContactTypes' do

  form           = '#new-admin-contact-type'
  new_link       = '#new-admin-contact-type-link'
  modal          = '#edit-contact-type-modal'

  submit_button  = '#submit-admin-contact-type-button'
  cancel_link    = '#cancel-admin-contact-type-link'
  
  table          = '#admin-contact-types-index'
  table_rows     = '#admin-contact-types-index tr'
  count_div      = '.admin-contact-types-count'
  stub_authorization!

  context 'new', :js => true do
  	before do 
  	  visit admin_contact_types_path
      click new_link
      wait_until_visible submit_button
    end

    it 'creates and shows contact type' do
      expect do 
        fill_in 'contact_type_name', :with => 'home phone'
        click submit_button
        wait_until_invisible form
      end.to change(ContactType, :count).by 1

      page.should have_content('home phone')
      within(count_div) { page.should have_content('Contact Types list(1)') }
      flash_created?
    end 

    it 'cancels creating' do 
      click cancel_link

      wait_until_invisible form
      click new_link

      wait_until_visible submit_button
      invisible? new_link
    end
  end

  context 'existing' do 
    before do
      @contact_type = create(:contact_type, :name => 'mobile') 
      visit admin_contact_types_path
    end

    context 'edit', :js => true do 
      before do 
        within(table) { click edit_link }
        wait_until_visible modal
      end

    	it 'edits contact type' do
    	  fill_in 'contact_type_name', :with => 'email'
    	  click submit_button 

    	  wait_until_invisible modal
    	  page.should have_content('email')
    	  page.should_not have_content('mobile')
        flash_updated?
    	end

      it 'cancels editting' do
        click cancel_link
        wait_until_invisible modal
      end
    end

  	it 'deletes contact type', :js => true do
      page.should have_content @contact_type.name
      within(count_div) { page.should have_content('Contact Types list(1)') }

      expect do 
        ensure_delete_is_working(delete_link, table_rows)
      end.to change(ContactType, :count).by -1

      within(count_div) { page.should_not have_content('Contact Types list(1)') }
      page.should_not have_content @contact_type.name
      flash_destroyed?
    end
  end

end