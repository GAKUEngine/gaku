require 'spec_helper'

describe 'Admin Specialties' do

  as_admin

  let(:specialty) { create(:specialty, :name => 'mobile') }

  before :all do
    set_resource "admin-specialty"
  end

  context 'new', :js => true do
    before do
      visit gaku.admin_specialties_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'specialty_name', :with => 'home phone'
        click submit
        wait_until_invisible form
      end.to change(Gaku::Specialty, :count).by 1

      page.should have_content 'home phone'
      within(count_div) { page.should have_content 'Specialties list(1)' }
      flash_created?
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before do
      specialty
      visit gaku.admin_specialties_path
    end

    context 'edit', :js => true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        fill_in 'specialty_name', :with => 'email'
        click submit

        wait_until_invisible modal
        page.should have_content 'email'
        page.should_not have_content 'mobile'
        flash_updated?
      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes', :js => true do
      page.should have_content specialty.name
      within(count_div) { page.should have_content 'Specialties list(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::Specialty, :count).by -1

      within(count_div) { page.should_not have_content 'Specialties list(1)' }
      page.should_not have_content specialty.name
      flash_destroyed?
    end
  end

end
