require 'spec_helper'

describe 'Admin EnrollmentStatusTypes' do

  stub_authorization!

  let(:enrollment_status_type) { create(:enrollment_status_type, :name => 'Admitted') }

  before :all do
    set_resource "admin-enrollment-status-type"
  end

  context 'new', :js => true do
  	before do
  	  visit gaku.admin_enrollment_status_types_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'enrollment_status_type_name', :with => 'Enrolled'
        click submit
        wait_until_invisible form
      end.to change(Gaku::EnrollmentStatusType, :count).by 1

      within(table) { page.should have_content 'Enrolled' }
      within(count_div) { page.should have_content 'Enrollment Status Types list(1)' }
      flash_created?
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before do
      enrollment_status_type
      visit gaku.admin_enrollment_status_types_path
    end

    context 'edit', :js => true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

    	it 'edits' do
    	  fill_in 'enrollment_status_type_name', :with => 'Expelled'
    	  click submit

    	  wait_until_invisible modal
    	  page.should have_content 'Expelled'
    	  page.should_not have_content 'Admitted'
        flash_updated?
    	end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end


  	it 'deletes', :js => true do
      page.should have_content enrollment_status_type.name
      within(count_div) { page.should have_content 'Enrollment Status Types list(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::EnrollmentStatusType, :count).by -1

      within(count_div) { page.should_not have_content 'Enrollment Status Types list(1)' }
      page.should_not have_content enrollment_status_type.name
      flash_destroyed?
    end
  end

end
