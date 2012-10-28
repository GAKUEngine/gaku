require 'spec_helper'

describe 'Admin Schools' do
  
  stub_authorization!
  
  before :all do
    Helpers::Request.resource("admin-school") 
  end

  context 'new', :js => true do
    before do 
      visit gaku.admin_schools_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do 
      expect do 
        fill_in 'school_name', :with => 'Nagoya University'
        click submit

        wait_until_invisible form
      end.to change(School, :count).by 1

      page.should have_content 'Nagoya University'
      within(count_div) { page.should have_content 'Schools list(1)' }
      flash_created?
    end 

    it 'cancels creating' do 
      ensure_cancel_creating_is_working
    end
  end

  context 'existing', :js => true do 
    before do
      @school = create(:school, :name => 'Varna Technical University') 
      visit gaku.admin_schools_path
    end

    context 'edit' do 
      before do 
        within(table) { click edit_link }
        wait_until_visible modal 
      end

      it 'edits'  do
        fill_in 'school_name', :with => 'Sofia Technical University'
        click submit

        wait_until_invisible modal
        page.should have_content 'Sofia Technical University'
        page.should_not have_content 'Varna Technical University'
        flash_updated?
      end

      it 'cancels editting' do 
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes' do
      within(count_div) { page.should have_content 'Schools list(1)' }
      page.should have_content @school.name

      expect do 
        ensure_delete_is_working 
      end.to change(School, :count).by -1

      within(count_div) { page.should_not have_content 'Schools list(1)' }
      page.should_not have_content @school.name
      flash_destroyed?
    end
  end

end