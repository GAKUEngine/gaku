require 'spec_helper'

describe 'Campuses' do

  form           = '#new-admin-school-campus'
  new_link       = '#new-admin-school-campus-link'
  modal          = '#edit-campus-modal'

  submit_button  = '#submit-admin-school-campus-button'
  cancel_link    = '#cancel-admin-school-campus-link'
  
  table          = '#admin-school-campuses-index'
  table_rows     = '#admin-school-campuses-index tr'
  count_div      = '.admin-school-campuses-count'

  stub_authorization!

  before do 
    @school = create(:school, :name => 'Nagoya University')
    visit admin_school_path(@school)
  end

  context 'new', :js => true do
    before do 
      click new_link
      wait_until_visible submit_button
    end

    it 'creates and shows campus' do 
      within(count_div) { page.should have_content('Campuses list(1)') }

      expect do 
        fill_in 'campus_name', :with => 'Nagoya Campus'
        click submit_button
        wait_until_invisible form
      end.to change(@school.campuses, :count).by 1

      page.should have_content 'Nagoya Campus'
      within(count_div) { page.should have_content('Campuses list(2)') }
      flash 'successfully created'
    end 

    it 'cancels creating' do
      click cancel_link
      wait_until_invisible form

      click new_link
      wait_until_visible submit_button
    end
  end

  context 'existing', :js => true do 
    
    context 'edit' do 
      before do 
        within(table) { click edit_link }
        wait_until_visible modal 
      end

      it 'edits campus' do
        fill_in 'campus_name', :with => 'Nagoya Campus'
        click submit_button 

        wait_until_invisible modal
        within(table) do 
          page.should have_content('Nagoya Campus')
          page.should_not have_content('Nagoya University') 
        end
        flash 'successfully updated'
      end

      it 'cancels editting' do 
        click cancel_link
        wait_until_invisible modal
      end
    end

    it 'deletes campus' do
      within(table) { page.should have_content("Nagoya University") }
      within(count_div) { page.should have_content('Campuses list(1)') }

      expect do 
        ensure_delete_is_working(delete_link, table_rows)
      end.to change(@school.campuses, :count).by -1

      within(table) { page.should_not have_content("Nagoya University") }
      within(count_div) { page.should_not have_content('Campuses list(1)') }
      flash 'successfully destroyed'
    end
  end

end