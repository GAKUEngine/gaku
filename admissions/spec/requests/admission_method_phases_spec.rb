require 'spec_helper'

describe 'Admin Admission Method Phases' do

  stub_authorization!

  let!(:admission_method) { create(:admission_method) }
  let(:admission_phase) { create(:admission_phase) }
  let(:admission_phase_state) { create( :admission_phase_state, 
                                        :can_progress => true, 
                                        :can_admit => true,
                                        :auto_progress => true,
                                        :auto_admit => false,
                                        :is_default => false,
                                        :name => 'Accepted') }
  let(:admission_phase_state2) { create(:admission_phase_state, :name => 'In Review') }

  before do
    set_resource "admin-admission-method-admission-phase"
    
  end

  context 'new', :js => true do
    before do
      visit gaku.admin_admission_method_path(admission_method)
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do 
      expect do
        fill_in 'admission_phase_name', :with => 'Exam'
        click submit
        wait_until_invisible form
      end.to change(Gaku::AdmissionPhase, :count).by 1

      page.should have_content 'Exam'
      within(count_div) { page.should have_content 'Admission Phases list(1)' }
      flash_created?
    end 

    it 'cancels creating' do
      ensure_cancel_creating_is_working
    end

  end

  context 'existing' do 

    before do
      admission_method.admission_phases<<admission_phase
      visit gaku.admin_admission_method_path(admission_method)
    end

    context 'phases states ' do
      context 'existing ', :js => true do
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
          page.should_not have_content("#{admission_phase_state.name}")
        end
        it 'edits ' do
          click edit_link
          wait_until_visible modal
          within('.state') do
            fill_in 'admission_phase_admission_phase_states_attributes_0_name', with: 'Rejected' 
            uncheck 'admission_phase_admission_phase_states_attributes_0_can_progress'
            uncheck 'admission_phase_admission_phase_states_attributes_0_can_admit'
            uncheck 'admission_phase_admission_phase_states_attributes_0_auto_progress'
          end
          click '#submit-admin-admission-method-admission-phase-button'
          wait_until_invisible modal

          #check edited values
          subject { admission_phase_state }
          its(:name) { should eq 'Rejected' }
          its(:can_progress) { should eq false }
        end 
      end
      context '#add', :js => true do
        it 'adds' do
          click edit_link
          wait_until_visible modal
          admission_method.admission_phases.first.admission_phase_states.count.should eq 0
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
          admission_method.admission_phases.first.admission_phase_states.count.should eq 0
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

    context '#edit ', :js => true do 
      before do 
        within(table) { click edit_link }
        wait_until_visible modal 
      end

      it 'edits' do
        fill_in 'admission_phase_name', :with => 'Interview'
        click submit
        #TODO check  
        #name
        #order
        #handler
      
        wait_until_invisible modal
        page.should have_content 'Interview'
        page.should_not have_content 'Exam'
        flash_updated?
      end

      it 'cancels editting' do 
        ensure_cancel_modal_is_working
      end
    end
    it 'deletes', :js => true do
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

  context 'when select back' do
    pending 'returns to admission_methods/index page' do
      click_on 'Back'
      current_path.should == "/admission_methods"
    end
  end

end