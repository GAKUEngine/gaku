require 'spec_helper'

describe 'Admin Attendance Types' do

  before { as :admin }
  before(:all) { set_resource 'admin-attendance-type' }

  let(:attendance_type) { create(:attendance_type, name: 'metro') }

  context 'new', js: true do
  	before do
  	  visit gaku.admin_root_path
      click '#attendance-types-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'attendance_type_name', with: 'new attendance type'
        page.has_css? '#attendance_type_disable_credit'
        page.has_css? '#attendance_type_counted_absent'
        page.has_css? '#attendance_type_auto_credit'
        click submit
        flash_created?
      end.to change(Gaku::AttendanceType, :count).by 1

      has_content? 'new attendance type'
      count? 'Attendance Types list(1)'
    end

    it { has_validations? }

  end

  context 'existing' do

    before do
      attendance_type
      visit gaku.admin_root_path
      click '#attendance-types-menu a'
    end

    context '#edit ', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'has validations' do
        fill_in 'attendance_type_name', with: ''
        has_validations?
      end

    	it 'edits' do
    	  fill_in 'attendance_type_name', with: 'car'
    	  click submit

    	  flash_updated?
    	  has_content? 'car'
    	  has_no_content? 'metro'
        expect(attendance_type.reload.name).to eq 'car'
    	end
    end

    it 'deletes', js: true do
      has_content? attendance_type.name
      count? 'Attendance Types list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::AttendanceType, :count).by(-1)

      count? 'Attendance Types list(1)'
      has_no_content? attendance_type.name
    end

  end

end
