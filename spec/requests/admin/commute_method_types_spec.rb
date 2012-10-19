require 'spec_helper'

describe 'CommuteMethodTypes' do

  form           = '#new-admin-commute-method-type'
  new_link       = '#new-admin-commute-method-type-link'
  modal          = '#edit-commute-method-type-modal'

  submit_button  = '#submit-admin-commute-method-type-button'
  cancel_link    = '#cancel-admin-commute-method-type-link'
  
  table          = '#admin-commute-method-types-index'
  table_rows     = '#admin-commute-method-types-index tr'
  count_div      = '.admin-commute-method-types-count'

  stub_authorization!

  context 'new', :js => true do
  	before do 
  	  visit admin_commute_method_types_path
      click new_link
      wait_until_visible submit_button
    end

    it 'creates and shows commute method type' do 
      expect do 
        fill_in 'commute_method_type_name', :with => 'car'
        click submit_button
        wait_until_invisible form
      end.to change(CommuteMethodType, :count).by 1

      page.should have_content('car')
      within(count_div) { page.should have_content('Commute Method Types list(1)') }
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
      @commute_method_type = create(:commute_method_type, :name => 'metro') 
      visit admin_commute_method_types_path
    end

    context 'edit', :js => true do 
      before do 
        within(table) { click edit_link }
        wait_until_visible modal 
      end

    	it 'edits commute method type' do
    	  fill_in 'commute_method_type_name', :with => 'car'
    	  click submit_button

    	  wait_until_invisible modal
    	  page.should have_content 'car'
    	  page.should_not have_content 'metro'
        flash_updated?
    	end

      it 'cancels editting' do 
        click cancel_link
        wait_until_invisible modal
      end
    end

  	it 'deletes commute method type', :js => true do
      page.should have_content @commute_method_type.name
      within(count_div) { page.should have_content('Commute Method Types list(1)') }

      expect do
        ensure_delete_is_working(delete_link, table_rows) 
      end.to change(CommuteMethodType, :count).by -1
        
      within(count_div) { page.should_not have_content('Commute Method Types list(1)') }
      page.should_not have_content @commute_method_type.name
      flash_destroyed?
    end
  end

end