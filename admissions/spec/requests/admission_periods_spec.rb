require 'spec_helper'

describe 'Admin Admission Periods' do

  stub_authorization!

  let(:admission_period) { create(:admission_period) }

  before do
    set_resource "admin-admission-period"
    visit gaku.admin_admission_periods_path
  end

  context 'new', :js => true do
    before do
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do 
      expect do
        fill_in 'admission_period_name', :with => 'Fall 2013'
        click submit
        wait_until_invisible form
      end.to change(Gaku::AdmissionPeriod, :count).by 1

      page.should have_content 'Fall 2013'
      within(count_div) { page.should have_content 'Admission Periods list(1)' }
      flash_created?
    end 

    it 'cancels creating' do 
      ensure_cancel_creating_is_working
    end

  end

  context 'existing' do 

    before do
      admission_period
      visit gaku.admin_admission_periods_path
    end

    context '#edit ', :js => true do 
      before do 
        within(table) { click edit_link }
        wait_until_visible modal 
      end

      it 'edits' do
        fill_in 'admission_period_name', :with => 'Summer 2013'
        click submit

        wait_until_invisible modal
        page.should have_content 'Summer 2013'
        page.should_not have_content 'Fall 2013'
        flash_updated?
      end

      it 'cancels editting' do 
        ensure_cancel_modal_is_working
      end
    end
    it 'deletes', :js => true do
      page.should have_content admission_period.name
      within(count_div) { page.should have_content 'Admission Periods list(1)' }

      expect do
        ensure_delete_is_working 
      end.to change(Gaku::AdmissionPeriod, :count).by -1
        
      within(count_div) { page.should_not have_content 'Admission Periods list(1)' }
      page.should_not have_content admission_period.name
      flash_destroyed?
    end

  end

end