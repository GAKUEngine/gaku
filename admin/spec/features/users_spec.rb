require 'spec_helper'

describe 'Admin Users' do

  before { as :admin }
  before(:all) { set_resource 'admin-user' }

  let(:user) { create(:user) }
  let!(:principal_role) { create(:role, name: 'principal') }
  let!(:teacher_role)   { create(:role, name: 'teacher') }


  context 'new', js: true do
    before do
      visit gaku.admin_root_path
      click '#users-menu a'
      click new_link
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
      visit gaku.admin_root_path
      click '#users-menu a'
    end

    context 'edit', js: true do
      before do
        within("#admin-users-index tbody tr#user-#{user.id}") { click js_edit_link }
        visible? modal
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

      expect do
        within("#admin-users-index tbody tr#user-#{user.id}") { click delete_link }
        accept_alert
        flash_destroyed?
      end.to change(Gaku::User, :count).by(-1)


      count? 'Users list(2)'
      has_no_content? user.username
    end

  end
end
