require 'spec_helper'

describe 'Admin Departments' do

  before { as :admin }
  before(:all) { set_resource 'admin-department' }

  let(:department) { create(:department, name: 'Ruby') }


  context 'new', js: true do
    before do
      visit gaku.admin_departments_path
      click new_link
      wait_until_visible submit
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
      visit gaku.admin_departments_path
    end

    context '#edit ', js: true do
      before do
        within(table) { click js_edit_link }
        wait_until_visible modal
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
      end.to change(Gaku::Department, :count).by(-1)

      flash_destroyed?
      count? 'Departments list(1)'
      has_no_content? department.name
    end

  end

end
