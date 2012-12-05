require 'spec_helper'

describe 'Admin Admissions' do

  stub_authorization!

  let(:admission_period_no_methods) { create(:admission_period_no_methods) }
  let(:admission_period) { create(:admission_period) }
  
  describe 'when select admission period', js: true do
    context 'when period has no methods' do
      before do
        admission_period_no_methods
        visit gaku.admin_admissions_path
        select "#{admission_period_no_methods.name}", from: 'admission_period'
      end
      it 'shows no methods info' do
        within ('#admission-method-selection') { page.should have_content 'No methods available for this period.' }
      end
    end

    context 'when period has methods' do
      before do

        admission_period
        visit gaku.admin_admissions_path

        @active_tab = page.find('.nav-tabs .active')
        @nav_tabs = page.find('.nav-tabs')
        @active_tab_content = page.find('.tab-content .active')
      end

      context 'default' do
        it 'selects the first period' do
          within ('#admission-period-selection') { page.should have_content "#{admission_period.name}" }
        end

        it 'selects the first method' do
          within ('#admission-method-selection') { page.should have_content "#{admission_period.admission_methods.first.name}" }
        end

        it 'shows first method\'s phases' do
          within (@nav_tabs) do
            page.should have_content "#{admission_period.admission_methods.first.admission_phases.first.name}"
            page.should have_content "#{admission_period.admission_methods.first.admission_phases.last.name}" 
          end
        end

        it 'open first phase\'s tab' do
          within(@active_tab) { page.should have_content "#{admission_period.admission_methods.first.admission_phases.first.name}" }
        end

        it 'shows first phase states' do
          within(@active_tab_content) do
            page.should have_content "#{admission_period.admission_methods.first.admission_phases.first.admission_phase_states.first.name}"
            page.should have_content "#{admission_period.admission_methods.first.admission_phases.first.admission_phase_states.last.name}"
          end
        end

      end

      context 'when change method' do
        before do
          select "#{admission_period.name}", from: 'admission_period'
          within('#admission-method-selection') { select "#{admission_period.admission_methods.last.name}", from: 'admission_method' }
        end

        it 'shows selected method\'s phases' do
          within (@nav_tabs)  do
            page.should have_content "#{admission_period.admission_methods.last.admission_phases.first.name}"
            page.should have_content "#{admission_period.admission_methods.last.admission_phases.last.name}" 
          end
        end

        it 'open first phase\'s tab' do
          within (@active_tab) { page.should have_content "#{admission_period.admission_methods.last.admission_phases.first.name}" }
        end

        it 'shows first phase states' do
          within (@active_tab_content) do
            page.should have_content "#{admission_period.admission_methods.last.admission_phases.first.admission_phase_states.first.name}"
            page.should have_content "#{admission_period.admission_methods.last.admission_phases.first.admission_phase_states.last.name}"
          end
        end

        it 'navigate thru phases' do
          within (@nav_tabs) { click_on "#{admission_period.admission_methods.last.admission_phases.last.name}" }
          wait_for_ajax
          #@active_tab_content = page.find('.tab-content .active')
          within (page.find('.tab-content .active')) do
            page.should have_content "#{admission_period.admission_methods.last.admission_phases.last.admission_phase_states.first.name}"
            page.should have_content "#{admission_period.admission_methods.last.admission_phases.last.admission_phase_states.last.name}"
          end
        end

      end
    end

    

  end
end