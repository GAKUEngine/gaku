require 'spec_helper'

describe 'Schools' do

  form           = '#new-admin-school'
  new_link       = '#new-admin-school-link'
  modal          = '#edit-school-modal'

  submit_button  = '#submit-admin-school-button'
  cancel_link    = '#cancel-admin-school-link'
  
  table          = '#admin-schools-index'
  table_rows     = '#admin-schools-index tr'
  count_div      = '.admin-schools-count'

  stub_authorization!

  context 'new', :js => true do
  	before do 
  	  visit admin_schools_path
      click new_link
      wait_until_visible submit_button
    end

    it 'creates and shows school' do 
      School.count.should eq 0

      fill_in 'school_name', :with => 'Nagoya University'
      click submit_button

      wait_until_invisible form
      page.should have_content('Nagoya University')
      within(count_div) { page.should have_content('Schools list(1)') }
      School.count.should eq 1
    end 

    it 'cancels creating' do 
      click cancel_link
      wait_until_invisible form

      click new_link
      wait_until_visible submit_button
    end
  end

  context 'existing', :js => true do 
    before do
      @school = create(:school, :name => 'Varna Technical University') 
      visit admin_schools_path
    end

    context 'edit' do 
      before do 
        within(table) { click edit_link }
        wait_until_visible modal 
      end

    	it 'edits school'  do
    	  fill_in 'school_name', :with => 'Sofia Technical University'
    	  click submit_button

    	  wait_until_invisible modal
    	  page.should have_content('Sofia Technical University')
    	  page.should_not have_content('Varna Technical University')
    	  School.count.should eq 1
    	end

      it 'cancels editting' do 
        click cancel_link
        wait_until_invisible modal
      end
    end

  	it 'deletes school' do
      School.count.should eq 1 
      within(count_div) { page.should have_content('Schools list(1)') }
      page.should have_content(@school.name)

      ensure_delete_is_working(delete_link, table_rows)

      within(count_div) { page.should_not have_content('Schools list(1)') }
      page.should_not have_content(@school.name)
      School.count.should eq 0
    end
  end

end