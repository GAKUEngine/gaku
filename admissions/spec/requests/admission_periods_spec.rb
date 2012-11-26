require 'spec_helper'

describe 'Admin Admission Periods' do

  stub_authorization!

  let(:admission_period) { create(:admission_period) }
  let(:admission_method) { create(:admission_method, :name => 'International Division Admissions') }
  let(:admission_method2) { create(:admission_method, :name => 'Regular Admissions') }

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

    pending 'cancels creating' do 
      ensure_cancel_creating_is_working
    end

  end

  context 'existing' do 

    before do
      admission_period
      visit gaku.admin_admission_periods_path
    end
    context 'methods ' do
      context 'existing ', :js => true do
        before do
          admission_method2
          set_resource 'admin-admission-period-admission-methods'
          admission_period.admission_methods<<admission_method
          visit gaku.admin_admission_periods_path
        end
        
        it 'shows all methods' do
          click_on 'Admission Methods list'
          wait_until_visible '#show-admission-period-admission-methods-modal'

          page.should have_content('Admission Methods list')
          within(table) do
            page.should have_content(admission_method.name)
          end
        end
        
        it '#deletes' do
          click edit_link
          wait_until_visible modal
          expect do
            click_on 'Remove'
            wait_for_ajax
            page.all('.method_form', :visible => true).count.should == 0
            click '#submit-admin-admission-period-button'
            wait_until_invisible modal
          end.to change(Gaku::PeriodMethodAssociation, :count).by -1
          
          flash_updated?
        end

        it 'edits ' do
          click edit_link
          wait_until_visible modal
          within('.method_form') do
            select "#{admission_method2.name}", from: 'admission_period_period_method_associations_attributes_0_admission_method_id' 
          end
          click '#submit-admin-admission-period-button'
          wait_until_invisible modal
          admission_period.reload
          admission_period.admission_methods.first.name.should eq admission_method2.name
          
          flash_updated?

          click_on 'Admission Methods list'
          wait_for_ajax
          within (table) do 
            page.should have_content admission_method2.name
            page.should_not have_content admission_method.name
          end
        end
        it 'adds ' do
          click edit_link
          wait_until_visible modal
          expect do
            click_on 'Add Admission Method'
            wait_for_ajax
            page.all('.method_form', :visible => true).count.should == 2
            select "#{admission_method2.name}", :from => 'admission_period[period_method_associations_attributes][0][admission_method_id]'
            click '#submit-admin-admission-period-button'
            wait_until_invisible modal
          end.to change(Gaku::PeriodMethodAssociation, :count).by 1
        end

      end
    end
    context '#edit ', :js => true do 
      before do 
        within(table) { click edit_link }
        wait_until_visible modal 
      end

      it 'edits' do
        fill_in 'admission_period_name', :with => 'Summer 2013'
        select '2013', from: 'admission_period_admitted_on_1i'
        select 'May', from: 'admission_period_admitted_on_2i'
        select '30', from: 'admission_period_admitted_on_3i'
        fill_in 'Seat Limit', with: 22
        click submit

        wait_until_invisible modal
        page.should have_content 'Summer 2013'
        page.should have_content '2013-05-30'
        page.should have_content 22
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