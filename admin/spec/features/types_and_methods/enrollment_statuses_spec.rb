require 'spec_helper'

describe 'Admin Enrollment Statuses' do

  before { as :admin }
  before(:all) { set_resource 'admin-enrollment-status' }

  let(:enrollment_status) { create(:enrollment_status_admitted) }

  context 'new', js: true do
  	before do
  	  visit gaku.admin_root_path
      click '#enrollment-statuses-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'enrollment_status_name', with: 'Enrolled'
        fill_in 'enrollment_status_code', with: 'enrolled'
        click submit
        flash_created?
      end.to change(Gaku::EnrollmentStatus, :count).by(1)

      within(table) { has_content? 'Enrolled' }
      count? 'Enrollment Statuses list(1)'
    end

    it { has_validations? }
  end

  context 'existing' do
    before do
      enrollment_status
      visit gaku.admin_root_path
      click '#enrollment-statuses-menu a'
    end

    context 'edit', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

    	it 'edits' do
    	  fill_in 'enrollment_status_name', with: 'Expelled'
    	  click submit

    	  flash_updated?
    	  has_content? 'Expelled'
    	  has_no_content? 'Admitted'
        expect(enrollment_status.reload.name).to eq 'Expelled'
    	end

      it 'has validations' do
        fill_in 'enrollment_status_code', with: ''
        has_validations?
      end
    end


  	it 'deletes', js: true do
      has_content? enrollment_status.name
      count? 'Enrollment Statuses list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::EnrollmentStatus, :count).by(-1)

      count? 'Enrollment Statuses list(1)'
      has_no_content? enrollment_status.name
    end

  end
end
