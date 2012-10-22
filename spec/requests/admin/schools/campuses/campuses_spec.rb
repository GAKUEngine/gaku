require 'spec_helper'

describe 'Admin School Campuses' do
  
  stub_authorization!

  before :all do
    Helpers::Request.resource("admin-school-campus")
  end

  before do 
    @school = create(:school, :name => 'Nagoya University')
    visit admin_school_path(@school)
  end

  context 'new', :js => true do
    before do 
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do 
      within(count_div) { page.should have_content 'Campuses list(1)' }

      expect do 
        fill_in 'campus_name', :with => 'Nagoya Campus'
        click submit
        wait_until_invisible form
      end.to change(@school.campuses, :count).by 1

      page.should have_content 'Nagoya Campus'
      within(count_div) { page.should have_content 'Campuses list(2)' }
      flash_created?
    end 

    it 'cancels creating' do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing', :js => true do 
    
    context 'edit' do 
      before do 
        within(table) { click edit_link }
        wait_until_visible modal 
      end

      it 'edits' do
        fill_in 'campus_name', :with => 'Nagoya Campus'
        click submit 

        wait_until_invisible modal
        within(table) do 
          page.should have_content 'Nagoya Campus'
          page.should_not have_content 'Nagoya University' 
        end
        flash_updated?
      end

      it 'cancels editting' do 
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes' do
      within(table) { page.should have_content "Nagoya University" }
      within(count_div) { page.should have_content 'Campuses list(1)' }

      expect do 
        ensure_delete_is_working
      end.to change(@school.campuses, :count).by -1

      within(table) { page.should_not have_content "Nagoya University" }
      within(count_div) { page.should_not have_content 'Campuses list(1)' }
      flash_destroyed?
    end
  end

end