require 'spec_helper'

describe 'Admin Admissions' do

  stub_authorization!

  let(:admission_period_no_methods) { create(:admission_period) }
  let(:admission_period) { create(:admission_period) }
  let(:admission_method_international) { create(:admission_method, name: 'International Division Admissions') }
  let(:admission_method_standart) { create(:admission_method, name: 'Regular Admissions') }
  let(:admission_phase_exam) { create(:admission_phase, name: 'Exam') }
  let(:admission_phase_interview) { create(:admission_phase, name: 'Interview') }
  let(:admission_phase_lang_exam) { create(:admission_phase, name: 'Foreign Language Exam') }
  let(:admission_phase_state_pre_exam) { create(:admission_phase_state, name: 'Pre-Exam') }
  let(:admission_phase_state_passed) { create(:admission_phase_state, name: 'Passed') }
  let(:admission_phase_state_abscent) { create(:admission_phase_state, name: 'Abscent') }
  let(:admission_phase_state_accepted) { create(:admission_phase_state, name: 'Accepted') }
  let(:admission_phase_state_waiting) { create(:admission_phase_state, name: 'Waiting for interview') }
  let(:admission_phase_state_rejected) { create(:admission_phase_state, name: 'Rejected') }


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
        admission_phase_interview.admission_phase_states<<admission_phase_state_waiting
        admission_phase_interview.admission_phase_states<<admission_phase_state_accepted
        admission_phase_interview.admission_phase_states<<admission_phase_state_rejected

        admission_phase_exam.admission_phase_states<<admission_phase_state_pre_exam
        admission_phase_exam.admission_phase_states<<admission_phase_state_passed
        admission_phase_exam.admission_phase_states<<admission_phase_state_abscent

        admission_phase_lang_exam.admission_phase_states<<admission_phase_state_pre_exam
        admission_phase_lang_exam.admission_phase_states<<admission_phase_state_passed
        admission_phase_lang_exam.admission_phase_states<<admission_phase_state_abscent

        admission_method_international.admission_phases<<admission_phase_lang_exam
        admission_method_international.admission_phases<<admission_phase_exam
        admission_method_international.admission_phases<<admission_phase_interview

        admission_method_standart.admission_phases<<admission_phase_exam
        admission_method_standart.admission_phases<<admission_phase_interview

        admission_period.admission_methods<<admission_method_standart
        admission_period.admission_methods<<admission_method_international
 
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
          within ('#admission-method-selection') { page.should have_content "#{admission_method_standart.name}" }
        end

        it 'shows first method\'s phases' do
          within (@nav_tabs) do
            page.should have_content "#{admission_method_standart.admission_phases.first.name}"
            page.should have_content "#{admission_method_standart.admission_phases.last.name}" 
          end
        end

        it 'open first phase\'s tab' do
          within(@active_tab) { page.should have_content "#{admission_method_standart.admission_phases.first.name}" }
        end

        it 'shows first phase states' do
          within(@active_tab_content) do
            page.should have_content "#{admission_method_standart.admission_phases.first.admission_phase_states.first.name}"
            page.should have_content "#{admission_method_standart.admission_phases.first.admission_phase_states.last.name}"
          end
        end

      end

      context 'when change method' do
        before do
          select "#{admission_period.name}", from: 'admission_period'
          within('#admission-method-selection') { select "#{admission_method_international.name}", from: 'admission_method' }
        end

        it 'shows selected method\'s phases' do
          within @nav_tabs  do
            page.should have_content "#{admission_method_international.admission_phases.first.name}"
            page.should have_content "#{admission_method_international.admission_phases.last.name}" 
          end
        end

        it 'open first phase\'s tab' do
          within(@active_tab) { page.should have_content "#{admission_method_international.admission_phases.first.name}" }
        end

        it 'shows first phase states' do
          within(@active_tab_content) do
            page.should have_content "#{admission_phase_lang_exam.admission_phase_states.first.name}"
            page.should have_content "#{admission_phase_lang_exam.admission_phase_states.last.name}"
          end
        end

      end
    end

    

  end
end