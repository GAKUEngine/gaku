require 'spec_helper'

describe 'Admin Departments' do

  before { as :admin }
  before(:all) { set_resource 'admin-department' }

  let(:department) { create(:department, name: 'Ruby') }


  context 'new', js: true do
    before do
      visit gaku.admin_root_path
      click '#departments-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'department_name', with: 'new department'
        click submit
        flash_created?
      end.to change(Gaku::Department, :count).by 1

      has_content? 'new department'
      count? 'Departments list(1)'
    end

    it { has_validations? }

  end

  context 'existing' do

    before do
      department
      visit gaku.admin_root_path
      click '#departments-menu a'
    end

    context '#edit ', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'has validations' do
        fill_in 'department_name', with: ''
        has_validations?
      end

      it 'edits' do
        fill_in 'department_name', with: 'Nodejs'
        click submit

        flash_updated?
        has_content? 'Nodejs'
        has_no_content? 'metro'
        expect(department.reload.name).to eq 'Nodejs'
      end
    end

    it 'deletes', js: true do
      has_content? department.name
      count? 'Departments list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::Department, :count).by(-1)

      count? 'Departments list(1)'
      has_no_content? department.name
    end

  end

end
