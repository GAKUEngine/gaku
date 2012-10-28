require 'spec_helper'

describe 'Admin CommuteMethodTypes' do

  stub_authorization!

  before :all do 
    Helpers::Request.resource("admin-commute-method-type")
  end

  context 'new', :js => true do
  	before do 
  	  visit gaku.admin_commute_method_types_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do 
      expect do 
        fill_in 'commute_method_type_name', :with => 'car'
        click submit
        wait_until_invisible form
      end.to change(Gaku::CommuteMethodType, :count).by 1

      page.should have_content 'car'
      within(count_div) { page.should have_content 'Commute Method Types list(1)' }
      flash_created?
    end 

    it 'cancels creating' do 
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do 
    before do
      @commute_method_type = create(:commute_method_type, :name => 'metro') 
      visit gaku.admin_commute_method_types_path
    end

    context 'edit', :js => true do 
      before do 
        within(table) { click edit_link }
        wait_until_visible modal 
      end

    	it 'edits' do
    	  fill_in 'commute_method_type_name', :with => 'car'
    	  click submit

    	  wait_until_invisible modal
    	  page.should have_content 'car'
    	  page.should_not have_content 'metro'
        flash_updated?
    	end

      it 'cancels editting' do 
        ensure_cancel_modal_is_working
      end
    end

  	it 'deletes', :js => true do
      page.should have_content @commute_method_type.name
      within(count_div) { page.should have_content 'Commute Method Types list(1)' }

      expect do
        ensure_delete_is_working 
      end.to change(Gaku::CommuteMethodType, :count).by -1
        
      within(count_div) { page.should_not have_content 'Commute Method Types list(1)' }
      page.should_not have_content @commute_method_type.name
      flash_destroyed?
    end
  end

end