require 'spec_helper'

describe 'Campuses' do

  form = '#new-admin-school-campus'
  new_link = '#new-admin-school-campus-link'
  modal = '#edit-campus-modal'

  submit_button = '#submit-admin-school-campus-button'
  cancel_link = '#cancel-admin-school-campus-link'
  
  table = 'table#admin-school-campuses-index'
  table_rows = 'table#admin-school-campuses-index tr'

  stub_authorization!

  before do 
    @school = create(:school, :name => 'Nagoya University')
    visit admin_school_path(@school)
  end

  context 'create and show' do
    before do 
      click new_link
      wait_until_visible submit_button
    end
    it 'should create and show school campus', :js => true do 
      @school.campuses.count.should eq 1

      fill_in 'campus_name', :with => 'Nagoya Campus'
      click submit_button

      wait_until_invisible form

      page.should have_content('Nagoya Campus')
      @school.campuses.count.should eq 2
    end 

    it 'should cancel creating', :js => true do
      click cancel_link

      wait_until_invisible form
      click new_link

      wait_until_visible submit_button
    end
  end

  context 'index, edit and delete' do 

  	it 'should edit school campus', :js => true do
  	  within(table) { click edit_link }
  	  
  	  wait_until_visible modal 
  	  fill_in 'campus_name', :with => 'Nagoya Campus'
  	  click submit_button 

  	  wait_until_invisible modal
      within(table) do 
  	    page.should have_content('Nagoya Campus')
  	    page.should_not have_content('Nagoya University') 
      end
  	  @school.campuses.count.should eq 1
  	end

  	it 'should delete school', :js => true do
      @school.campuses.count.should eq 1 
      tr_count = size_of table_rows

      click delete_link 
      accept_alert
        
      wait_until { size_of(table_rows) == tr_count - 1 }
      @school.campuses.count.should eq 0
    end
  end

end