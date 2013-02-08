require 'spec_helper'

describe 'Admin Attendance Types' do

  as_admin

  let(:attendance_type) { create(:attendance_type, :name => 'metro') }

  before :all do
    set_resource "admin-attendance-type"
  end

  context 'new', :js => true do
  	before do
  	  visit gaku.admin_attendance_types_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'attendance_type_name', :with => 'car'
        click submit
        wait_until_invisible form
      end.to change(Gaku::AttendanceType, :count).by 1

      page.should have_content 'car'
      within(count_div) { page.should have_content 'Attendance Types list(1)' }
      flash_created?
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do

    before do
      attendance_type
      visit gaku.admin_attendance_types_path
    end

    context '#edit ', :js => true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

    	it 'edits' do
    	  fill_in 'attendance_type_name', :with => 'car'
    	  click submit

    	  wait_until_invisible modal
    	  page.should have_content 'car'
    	  page.should_not have_content 'metro'
        flash_updated?
    	end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes', :js => true do
      page.should have_content attendance_type.name
      within(count_div) { page.should have_content 'Attendance Types list(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::AttendanceType, :count).by -1

      within(count_div) { page.should_not have_content 'Attendance Types list(1)' }
      page.should_not have_content attendance_type.name
      flash_destroyed?
    end

  end

end
