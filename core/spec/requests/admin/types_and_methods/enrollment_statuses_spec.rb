require 'spec_helper'

describe 'Admin Enrollment Statuses' do

  as_admin

  let(:enrollment_status) { create(:enrollment_status_admitted) }

  before :all do
    set_resource "admin-enrollment-status"
  end

  context 'new', :js => true do
  	before do
  	  visit gaku.admin_enrollment_statuses_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'enrollment_status_name', :with => 'Enrolled'
        fill_in 'enrollment_status_code', :with => 'enrolled'
        click submit
        wait_until_invisible form
      end.to change(Gaku::EnrollmentStatus, :count).by 1

      within(table) { page.should have_content 'Enrolled' }
      within(count_div) { page.should have_content 'Enrollment Statuses list(1)' }
      flash_created?
    end

    it { has_validations? }

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before do
      enrollment_status
      visit gaku.admin_enrollment_statuses_path
    end

    context 'edit', :js => true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

    	it 'edits' do
    	  fill_in 'enrollment_status_name', :with => 'Expelled'
    	  click submit

    	  wait_until_invisible modal
    	  page.should have_content 'Expelled'
    	  page.should_not have_content 'Admitted'
        flash_updated?
    	end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end

      it 'has validations' do
        fill_in 'enrollment_status_code', :with => ''
        has_validations?
      end

    end


  	it 'deletes', :js => true do
      page.should have_content enrollment_status.name
      within(count_div) { page.should have_content 'Enrollment Statuses list(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::EnrollmentStatus, :count).by -1

      within(count_div) { page.should_not have_content 'Enrollment Statuses list(1)' }
      page.should_not have_content enrollment_status.name
      flash_destroyed?
    end
  end

end
