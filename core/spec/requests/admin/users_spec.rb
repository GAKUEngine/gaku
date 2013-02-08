require 'spec_helper'

describe 'Admin Roles' do

  as_admin

  let(:user) { create(:user) }
  let(:principal_role) { create(:role, :name => 'principal') }
  let(:teacher_role) { create(:role, :name => 'teacher') }

  before :all do
    set_resource "admin-user"
  end

  context 'new', :js => true do
    before do
      principal_role
      teacher_role
      visit gaku.admin_users_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'user_username', :with => 'Susumu Yokota'
        fill_in 'user_email', :with => "susumu@example.com"
        fill_in 'user_password', :with => '123456'
        fill_in 'user_password_confirmation', :with => '123456'
        find(:css, "#user_role_ids_[value='1']").set(true)
        click submit
        wait_until_invisible form
      end.to change(Gaku::User, :count).by 1

      page.should have_content 'Susumu Yokota'
      page.should have_content 'susumu@example.com'
      within(count_div) { page.should have_content 'Users list(2)' }
      flash_created?
    end

    it 'validates' do
      fill_in 'user_username', :with => ''
      click submit

      page.should have_content "can't be blank"
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end

  end

  context 'existing' do
    before do
      user
      visit gaku.admin_users_path
    end

    context 'edit', :js => true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        old_username = user.username
        fill_in 'user_username', :with => 'ninja'
        click submit

        wait_until_invisible modal
        page.should have_content 'ninja'
        page.should_not have_content old_username
        flash_updated?
      end

      it 'validates' do
        fill_in 'user_username', :with => ''
        click submit

        page.should have_content "can't be blank"
      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes', :js => true do
      page.should have_content user.username
      within(count_div) { page.should have_content 'Users list(2)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::User, :count).by -1

      within(count_div) { page.should_not have_content 'Users list(2)' }
      page.should_not have_content user.username
      flash_destroyed?
    end
  end

end
