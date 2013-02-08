require 'spec_helper'

describe 'Admin Roles' do

  stub_authorization!

  let(:role) { create(:role, :name => 'teacher') }

  before :all do
    set_resource "admin-role"
  end

  context 'new', :js => true do
    before do
      visit gaku.admin_roles_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'role_name', :with => 'master admin'
        click submit
        wait_until_invisible form
      end.to change(Gaku::Role, :count).by 1

      page.should have_content 'master admin'
      within(count_div) { page.should have_content 'Roles list(1)' }
      flash_created?
    end

    it 'validates' do
      fill_in 'role_name', :with => ''
      click submit

      page.should have_content "can't be blank"
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before do
      role
      visit gaku.admin_roles_path
    end

    context 'edit', :js => true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        fill_in 'role_name', :with => 'ninja'
        click submit

        wait_until_invisible modal
        page.should have_content 'ninja'
        page.should_not have_content 'teacher'
        flash_updated?
      end

      it 'validates' do
        fill_in 'role_name', :with => ''
        click submit

        page.should have_content "can't be blank"
      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes', :js => true do
      page.should have_content role.name
      within(count_div) { page.should have_content 'Roles list(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::Role, :count).by -1

      within(count_div) { page.should_not have_content 'Roles list(1)' }
      page.should_not have_content role.name
      flash_destroyed?
    end
  end

end
