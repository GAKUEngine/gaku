require 'spec_helper'

describe 'Admin Users' do

  before { as :admin }
  before(:all) { set_resource 'admin-user' }

  let(:user) { create(:user) }
  let!(:principal_role) { create(:role, name: 'principal') }
  let!(:teacher_role)   { create(:role, name: 'teacher') }


  context 'new', js: true do
    before do
      visit gaku.admin_users_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'user_username', with: 'Susumu Yokota'
        fill_in 'user_email', with: 'susumu@example.com'
        fill_in 'user_password', with: '123456'
        fill_in 'user_password_confirmation', with: '123456'
        find(:css, "#user_role_ids_[value='#{principal_role.id}']").set(true)
        click submit
        flash_created?
      end.to change(Gaku::User, :count).by(1)

      has_content? 'Susumu Yokota'
      has_content? 'susumu@example.com'
      count? 'Users list(2)'
    end

    it 'validates' do
      fill_in 'user_username', with: ''
      click submit
      has_validations?
    end
  end

  context 'existing' do
    before do
      user
      visit gaku.admin_users_path
    end

    context 'edit', js: true do
      before do
        within("#admin-users-index tbody tr#user-#{user.id}") { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        old_username = user.username
        fill_in 'user_username', with: 'ninja'
        click submit

        flash_updated?
        has_content? 'ninja'
        has_no_content? old_username
      end

      it 'validates' do
        fill_in 'user_username', with: ''
        click submit

        has_validations?
      end
    end

    it 'deletes', js: true do
      has_content? user.username
      count? 'Users list(2)'

      tr_count = size_of table_rows

      expect do
        within("#admin-users-index tbody tr#user-#{user.id}") { click delete_link }
        accept_alert
        wait_until { size_of(table_rows) == tr_count - 1 }
      end.to change(Gaku::User, :count).by(-1)

      flash_destroyed?
      count? 'Users list(2)'
      has_no_content? user.username
    end

  end
end
