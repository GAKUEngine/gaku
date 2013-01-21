require 'spec_helper'

describe 'Admin Admissions' do

  stub_authorization!

  let(:admission_period_no_methods) { create(:admission_period_no_methods) }
  let(:admission_period) { create(:admission_period) }
  let(:exam) { create(:exam) }
  let(:attendance) { create(:attendance) }
  let!(:enrollment_status_applicant) { create(:enrollment_status_applicant, id:1) }
  let(:student) { create(:student, enrollment_status:enrollment_status_applicant) }

  describe 'when select admission period', js: true do
    context 'without methods' do
      before do
        admission_period_no_methods
        visit gaku.admin_admissions_path
        select "#{admission_period_no_methods.name}", from: 'admission_period'
      end
      it 'shows no methods info' do
        within ('#admission-method-selection') { page.should have_content 'No methods available for this period.' }
      end
    end

    context 'with methods' do
      before do
        admission_period
        visit gaku.admin_admissions_path

        @active_tab = page.find('.nav-tabs .active') #first time throws error
        @nav_tabs = page.find('.nav-tabs')
        @active_tab_content = page.find('.tab-content .active')
        @first_method = admission_period.admission_methods.first
        @last_method = admission_period.admission_methods.last
      end

      context 'default' do
        it 'selects the first period' do
          within ('#admission-period-selection') { page.should have_content "#{admission_period.name}" }
        end

        it 'selects the first method' do
          within ('#admission-method-selection') { page.should have_content "#{@first_method.name}" }
        end

        it 'shows first method\'s phases' do
          within (@nav_tabs) do
            page.should have_content "#{@first_method.admission_phases.first.name}"
            page.should have_content "#{@first_method.admission_phases.last.name}" 
          end
        end

        it 'open first phase\'s tab' do
          within(@active_tab) { page.should have_content "#{@first_method.admission_phases.first.name}" }
        end

        it 'shows first phase states' do
          within(@active_tab_content) do
            page.should have_content "#{@first_method.admission_phases.first.admission_phase_states.first.name}"
            page.should have_content "#{@first_method.admission_phases.first.admission_phase_states.last.name}"
          end
        end

      end

      context 'when change method' do
        before do
          select "#{admission_period.name}", from: 'admission_period'
          wait_for_ajax
          within('#admission-method-selection') { select "#{@last_method.name}", from: 'admission_method' }
          wait_for_ajax
        end

        it 'shows selected method\'s phases' do
          within (@nav_tabs)  do
            page.should have_content "#{@last_method.admission_phases.first.name}"
            page.should have_content "#{@last_method.admission_phases.last.name}" 
          end
        end

        it 'open first phase\'s tab' do
          within (@active_tab) { page.should have_content "#{@last_method.admission_phases.first.name}" }
        end

        it 'shows first phase states' do
          within (@active_tab_content) do
            page.should have_content "#{@last_method.admission_phases.first.admission_phase_states.first.name}"
            page.should have_content "#{@last_method.admission_phases.first.admission_phase_states.last.name}"
          end
        end

        it 'navigate thru phases' do
          within (@nav_tabs) { click_on "#{@last_method.admission_phases.last.name}" }
          wait_for_ajax
          within (@active_tab_content) do
            page.should have_content "#{@last_method.admission_phases.last.admission_phase_states.first.name}"
            page.should have_content "#{@last_method.admission_phases.last.admission_phase_states.last.name}"
          end
        end
      end
      context 'applicants' do
        context 'new students' do
          before do
            click_on 'New Applicant'
            wait_for_ajax
          end
          it 'adds new' do
            expect do
              fill_in 'admission_student_attributes_name', with: 'Marta'
              fill_in 'admission_student_attributes_surname', with: 'Kostova'
              click_on 'Create Student'
              wait_until_visible('#new-admin-admission-link')
              wait_until_invisible('#cancel-admin-admission-link')
            end.to change(Gaku::Admission, :count).by 1

            within ('#state1' ) do
              within('#students-index') { page.should have_content ('Marta') }
            end
          end

          it 'has validations' do
            click_on 'Create Student'
            page.should have_content "can't be blank" 
          end

          it 'cancels adding' do
            expect do
              click_on 'Cancel'
              wait_until_visible('#new-admin-admission-link')
              wait_until_invisible('#cancel-admin-admission-link')
            end.to change(Gaku::Admission, :count).by 0
          end
        end

        context 'existing students' do
          before do
            student
            admission_period
            visit gaku.admin_admissions_path
            click_on 'new-create-multiple-admissions-student-link'
            wait_for_ajax          
          end

          it 'adds existing' do
            expect do
              find(:css, "input#student-#{student.id}").set(true)
              wait_for_ajax
              wait_until_visible '#students-checked-div'

              within('#students-checked-div') do
                page.should have_content 'Chosen students(1)'
                click_link 'Show'
                wait_for_ajax
                wait_until_visible '#chosen-table'
                page.should have_content "#{student.name}"
                click_on 'Create'
                wait_for_ajax
                wait_until { page.should_not have_css('#student-modal') }
              end
            end.to change(Gaku::Admission, :count).by 1
            within ('#state1' ) do
              within('#students-index') { page.should have_content ("#{student.name}") }
            end
          end
          it 'cancels adding' do
            expect do
              click_on 'Cancel'
              wait_until_visible('#new-admin-admission-link')
              wait_until_invisible('#cancel-class-group-student-link')
            end.to change(Gaku::Admission, :count).by 0
          end
        end

        context 'Journey - add new student and' do
          before do
            click_on 'New Applicant'
            wait_for_ajax
            #add new student
            expect do
              fill_in 'admission_student_attributes_name', with: 'Marta'
              fill_in 'admission_student_attributes_surname', with: 'Kostova'
              click_on 'Create Student'
              wait_until_visible('#new-admin-admission-link') #first time throws error
              wait_until_invisible('#cancel-admin-admission-link')
            end.to change(Gaku::Admission, :count).by 1
            page.should have_content("Exam(1)")
            within ('#state1' ) do
              within('#students-index') { page.should have_content ('Marta') }
            end

          end
          it 'change state' do
            #Exam | Pre Exam
            within("#state#{@first_method.admission_phases.first.admission_phase_states.first.id}") {
              select "Abscent", from: 'state_id'
              click_on 'Save'
              wait_for_ajax
              sleep 1
              wait_until { size_of("#students-index tbody tr").should eq 0 }
              page.should_not have_content 'Admitted on'
            }
            page.should have_content("Interview(0)")
            #Exam | Abscent
            within("#state#{@first_method.admission_phases.first.admission_phase_states.last.id}") {
              size_of("#students-index tbody tr").should eq 1
              select "Passed", from: 'state_id'
              click_on 'Save'
              sleep 1
              wait_until { size_of("#students-index tbody tr").should eq 0 }
            }
            #Exam | Passed
            within("#state#{@first_method.admission_phases.first.admission_phase_states.second.id}") {
              size_of("#students-index tbody tr").should eq 1
              page.should_not have_content 'Admitted on'
              click_on 'Save'
              sleep 1
            }
            page.should have_content "Interview(1)"
            click_on ("Interview(1)")
            page.should have_content 'Marta'
            #Interview | Waiting for Interview
            within("#state#{@first_method.admission_phases.last.admission_phase_states.first.id}") { #first time throws error
              size_of("#students-index tbody tr").should eq 1
              page.should_not have_content 'Admitted on'
              select "Accepted", from: 'state_id'
              click_on 'Save'
              sleep 1
            }
            #Interview | Accepted
            within("#state#{@first_method.admission_phases.last.admission_phase_states.second.id}") {
              size_of("#students-index tbody tr").should eq 1
              page.should have_content 'Admitted On'
            }
            #TODO revert admitted if admitted by mistake
            visit gaku.students_path
            page.should have_content 'Marta'
            page.should have_content 'Admitted On'
          end
          context 'grading' do
            before do
              admission_period
              attendance
              @exam_phase = admission_period.admission_methods.first.admission_phases.first
              #@exam_phase.exam = exam
              admission_period.reload
              visit gaku.admin_admissions_path
            end
            context 'grades' do
              before do
                page.should have_content 'Grade Exam'
                click_on 'Grade Exam'
                page.should have_content "#{exam.name}"
              end
              it 'grades' do
                fill_in 'portion_score', with: 89
                sleep 1 #this is needed because sometimes test fails
                click '.exam-parts' #TODO fix this
                wait_for_ajax
                visit gaku.admin_admissions_path
                select 'Passed', from: 'state_id'
                click_on 'Save'
                page.should have_content 89
              end
              it 'errors with invalid points' do
                fill_in 'portion_score', with: -120 #Max score is 100
                click '.exam-parts' #TODO fix this
                wait_for_ajax
                page.has_css?('.score-error')
                fill_in 'portion_score', with: 120
                click '.exam-parts' #TODO fix this
                wait_for_ajax
                page.has_css?('.score-error')
                visit gaku.admin_admissions_path
                select 'Passed', from: 'state_id'
                click_on 'Save'
                page.should_not have_content 120
              end
            end
            
            context 'attendance' do
              before do
                page.has_content?('Grade Exam') 
                click_on 'Grade Exam'
                page.should have_content "#{exam.name}"
                click '.btn'
                wait_until_visible '.popover-content'
                #TODO add some predefined reasons
              end
              it 'selects attendance reason' do
                select 'Illness', from: 'preset-reasons'
                click_on 'Submit'
                page.should_not have_css '.popover-content'
                find('.score-cell')['disabled'].should == "true" #for phantom it should == "disabled"
              end
              it 'adds attendance custom reason' do
                fill_in 'custom-reason', with: 'Illness' 
                click_on 'Submit'
                page.should_not have_css '.popover-content'
                find('.score-cell')['disabled'].should == "true"
              end
              it 'removes attendance reason' do
                fill_in 'custom-reason', with: 'Illness' 
                click_on 'Submit'
                page.should_not have_css '.popover-content'
                find('.score-cell')['disabled'].should == "true"
                #TODO remove duplication
                click '.btn'
                page.find('.delete-attendance').click
                wait_for_ajax
                find('.score-cell')['disabled'].should == nil
              end
            end
          end

          context 'listing' do
            it 'lists admissions' do
              page.should have_content 'Listing Admissions'
              click_on 'Listing Admissions'
              current_path.should == "/admin/admissions/listing_admissions"
              page.should have_content 'Admission Candidates List'
              page.should have_content "#{admission_period.admission_methods.first.name}"
              page.should have_content "#{admission_period.admission_methods.first.admission_phases.first.name}"
            end
            context 'lists applicants and' do
              before do
                page.should have_content 'Applicants List'
                click_on 'Applicants List'
                current_path.should == "/admin/admissions/listing_applicants"
              end
              it 'edits applicants' do
                click '.edit-link'
                wait_until_visible modal
                fill_in 'student_name', with: 'Martina'
                click_on 'Save Student'
                wait_until_invisible modal
                page.has_content?('Martina')
                visit gaku.listing_applicants_admin_admissions_path
                page.has_content?('Martina')
              end
              it 'shows applicants' do
                click '.show-link'
                current_path.should eq "/students/1"
                page.has_content? 'Martina'
              end
              it 'returns to admissions' do
                page.should have_content 'Admissions'
                click_on 'Admissions'
                current_path.should eq "/admin/admissions"
                page.has_content? 'Admission Candidates List'
              end
            end

          end
          
          pending 'exports as CSV' do
          end
        end

      end

    end

  end
end