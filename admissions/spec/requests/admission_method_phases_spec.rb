require 'spec_helper'

describe 'Admin Admission Method Phases' do

  as_admin

  let!(:admission_method) { create(:admission_method_without_phases) }
  let(:admission_phase) { create(:admission_phase, admission_method: admission_method) }
  let(:admission_phase_state) { create( :admission_phase_state,
                                        :can_progress => true,
                                        :can_admit => true,
                                        :auto_progress => true,
                                        :auto_admit => false,
                                        :is_default => false,
                                        :name => 'Accepted') }
  let(:admission_phase_state2) { create(:admission_phase_state, :name => 'In Review') }
  let(:exam) { create(:exam) }

  before do
    set_resource "admin-admission-method-admission-phase"
  end

  context 'new', js: true do
    before do
      visit gaku.admin_admission_method_path(admission_method)
      click new_link
      wait_until_visible submit
      wait_for_ajax
    end

    it 'creates and shows' do
      expect do
        fill_in 'admission_phase_name', :with => 'Written application'
        click submit
        wait_until_invisible form
      end.to change(Gaku::AdmissionPhase, :count).by 1

      page.should have_content 'Written application'
      within(count_div) { page.should have_content 'Admission Phases list(1)' }
      flash_created?
    end

    it 'cancels creating' do
      ensure_cancel_creating_is_working
    end

    it {has_validations?}

  end

  context 'existing' do

    before do
      admission_phase
      visit gaku.admin_admission_method_path(admission_method)
    end

    context 'phases states ' do
      context 'existing ', js: true do
        before do
          set_resource 'admin-admission-method-admission-phase-states'
          admission_method.admission_phases.first.admission_phase_states<<admission_phase_state
          admission_method.admission_phases.first.admission_phase_states<<admission_phase_state2
          visit gaku.admin_admission_method_path(admission_method)
        end

        context 'list ' do
          before do
            click_on 'Admission Phase States list'
            wait_until_visible '#show-admission-method-admission-phase-states-modal'
          end

          it 'shows all states' do
            page.should have_content('Admission Phase States list')
            within(table) do
              page.should have_content(admission_phase_state.name)
              page.should have_css('#set-primary-link')
              all('.vm-tc').count.should > 0
            end
          end

          pending 'changes the default state' do
            click '#set-primary-link'
            #TODO
          end
        end

        it '#deletes' do
          click edit_link
          wait_until_visible modal
          expect do
            click_on 'Remove state'
            wait_for_ajax
            page.all('.state', :visible => true).count.should == 1
            click '#submit-admin-admission-method-admission-phase-button'
            wait_until_invisible modal
          end.to change(Gaku::AdmissionPhaseState, :count).by -1
          click_on 'Admission Phase States list'
          wait_until_visible '#show-admission-method-admission-phase-states-modal'
          page.should_not have_content(admission_phase_state.name)
        end

        it 'edits ' do
          click edit_link
          wait_until_visible modal
          within('#admission-phase-state-'+admission_phase_state.id.to_s) do
            click edit_link
            fill_in 'admission_phase_state_name', with: 'Rejected'
            uncheck 'admission_phase_state_can_progress'
            uncheck 'admission_phase_state_can_admit'
            uncheck 'admission_phase_state_auto_progress'
            click '#submit-admin-admission-method-admission-phase-admission-phase-state-button'
          end

          click '#submit-admin-admission-method-admission-phase-button'
          wait_until_invisible modal
          admission_phase_state.reload
          admission_phase_state.name.should eq 'Rejected'
          admission_phase_state.can_progress.should eq false
          admission_phase_state.can_admit.should eq false
          admission_phase_state.auto_progress.should eq false

          flash_updated?

          click_on 'Admission Phase States list'
          wait_for_ajax
          within (table) do
            page.should have_content 'Rejected'
            page.should_not have_content 'Accepted'
          end
        end
      end

      context '#add', js: true do
        it 'adds' do
          click edit_link
          wait_until_visible modal
          admission_method.admission_phases.first.admission_phase_states.count.should eq 1
          expect do
            click_on 'Add Admission Phase State'
            wait_for_ajax
            page.all('.state', :visible => true).count.should == 1
            within('.state') { find(:css, "input").set('Written Report') }
            click '#submit-admin-admission-method-admission-phase-button'
            wait_until_invisible modal
          end.to change(Gaku::AdmissionPhaseState, :count).by 1
        end

        it 'cancels adding' do
          click edit_link
          wait_until_visible modal
          admission_method.admission_phases.first.admission_phase_states.count.should eq 1
          expect do
            click_on 'Add Admission Phase State'
            wait_for_ajax
            page.all('.state', :visible => true).count.should == 1
            within('.state') { find(:css, "input").set('Written Report') }
            click cancel_link
          end.to change(Gaku::AdmissionPhaseState, :count).by 0
        end
      end

    end

    context '#edit ', js: true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        fill_in 'admission_phase_name', :with => 'Interview'
        fill_in 'admission_phase_phase_handler', :with => 3
        click submit
        wait_until_invisible modal

        within("#admission-method-admission-phase-#{admission_phase.id}") do
          page.should have_content 'Interview'
          page.should_not have_content 'Written application'
          page.should have_content 3
        end
        flash_updated?
      end

      it 'cancels editting' do
        ensure_cancel_modal_is_working
      end
    end

    context 'add exam', js:true do
      context ' #new ' do
        before do
          click_on 'New Exam'
          wait_until_visible modal
        end
        it 'adds exams' do
          fill_in 'exam_name', with: 'Essay'
          click_on 'Save Exam'
          wait_until_invisible modal
          page.should have_content 'Essay'
        end
        it 'has_validations' do
          click_on 'Save Exam'
          wait_until { page.should have_content "can't be blank" }
        end
        it 'cancel adding' do
          click_on 'Cancel'
          wait_until_invisible modal
          page.should have_content "New Exam"
          page.should have_content "Add Existing Exam"
        end
      end
      context 'add existing exam' do
        before do
          exam
          visit gaku.admin_admission_method_path(admission_method)
          click_on 'Add Existing Exam'
          wait_until_visible modal
        end
        it 'adds existing exam' do
          select "#{exam.name}", from: 'exam_id'
          click_on 'Add Exam'
          wait_until_invisible modal
          page.should have_content "#{exam.name}"
        end
        it 'cancels adding' do
          click_on 'Cancel'
          wait_until_invisible modal
          page.should have_content "New Exam"
          page.should have_content "Add Existing Exam"
        end
      end

      context 'existing exam' do
        before do
          admission_phase.exam=exam
          visit gaku.admin_admission_method_path(admission_method)
        end
        it 'removes exams' do
          page.should have_content "#{exam.name}"
          click '.delete-link'
          accept_alert
          page.should_not have_content "#{exam.name}"
          page.should have_content "New Exam"
          page.should have_content "Add Existing Exam"  
        end
      end

    end
      
    it 'deletes', js: true do
      page.should have_content admission_phase.name
      within(count_div) { page.should have_content 'Admission Phases list(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::AdmissionPhase, :count).by -1

      within(count_div) { page.should_not have_content 'Admission Phases list(1)' }
      page.should_not have_content admission_phase.name
      flash_destroyed?
    end
  end

end
