require 'spec_helper'

describe 'Admin Roles' do

  before { as :admin }
  before(:all) { set_resource 'admin-role' }

  let(:role) { create(:role, name: 'teacher') }

  context 'new', js: true do
    before do
      visit gaku.admin_root_path
      click '#roles-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'role_name', with: 'master admin'
        click submit
        flash_created?
      end.to change(Gaku::Role, :count).by 1

      has_content? 'master admin'
      count? 'Roles list(2)'
    end

    it 'validates' do
      fill_in 'role_name', with: ''
      click submit

      has_content? "can't be blank"
    end

  end

  context 'existing' do
    before do
      role
      visit gaku.admin_root_path
      click '#roles-menu a'
    end

    context 'edit', js: true do
      before do
        within('#admin-roles-index tbody tr:nth-child(2)') { click js_edit_link }
        visible? modal
      end

      it 'edits' do
        fill_in 'role_name', with: 'ninja'
        click submit
        flash_updated?

        expect(role.reload.name).to eq 'ninja'
        has_content? 'ninja'
        has_no_content? 'teacher'
      end

      it 'validates' do
        fill_in 'role_name', with: ''
        click submit

        has_content? "can't be blank"
      end

    end

    it 'deletes', js: true do
      has_content? role.name
      within(count_div) { has_content? 'Roles list(2)' }

      expect do
        within('#admin-roles-index tbody tr:nth-child(2)') { click delete_link }
        accept_alert
        flash_destroyed?
      end.to change(Gaku::Role, :count).by -1

      count? 'Roles list(2)'

      has_content? role.name
    end
  end

end
