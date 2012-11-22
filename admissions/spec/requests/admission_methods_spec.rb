require 'spec_helper'

describe 'Admin Admission Methods' do

  stub_authorization!

  let(:admission_method) { create(:admission_method) }

  before do
    set_resource "admin-admission-method"
  end

  context 'new', :js => true do
    before do
      visit gaku.admin_admission_methods_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do 
      expect do 
        fill_in 'admission_method_name', :with => 'Standart'
        click submit
        wait_until_invisible form
      end.to change(Gaku::AdmissionMethod, :count).by 1

      page.should have_content 'Standart'
      within(count_div) { page.should have_content 'Admission Methods list(1)' }
      flash_created?
    end 

    it 'cancels creating' do 
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do 

    before do
      admission_method
      visit gaku.admin_admission_method_path(admission_method)
    end

    context '#edit ', :js => true do 
      before do 
        within(table) { click edit_link }
        wait_until_visible modal 
      end

      it 'edits' do
        fill_in 'admission_method_name', :with => 'Early'
        click submit

        wait_until_invisible modal
        page.should have_content 'Early'
        page.should_not have_content 'Standart'
        flash_updated?
      end

      it 'cancels editting' do 
        ensure_cancel_modal_is_working
      end
    end
    it 'deletes', :js => true do
      page.should have_content admission_method.name
      within(count_div) { page.should have_content 'Admission Methods list(1)' }

      expect do
        ensure_delete_is_working 
      end.to change(Gaku::AdmissionMethod, :count).by -1
        
      within(count_div) { page.should_not have_content 'Admission Methods list(1)' }
      page.should_not have_content admission_method.name
      flash_destroyed?
    end

  end

end