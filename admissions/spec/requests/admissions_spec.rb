require 'spec_helper'

describe 'Admin Admissions' do

  as_admin

  let(:admission_period_no_methods) { create(:admission_period_no_methods) }
  let(:admission_period) { create(:admission_period) }
  let(:exam) { create(:exam) }
  let(:attendance) { create(:attendance) }
  let!(:enrollment_status_applicant) { create(:enrollment_status_applicant, id:1) }
  let!(:enrollment_status_admitted) { create(:enrollment_status_admitted, id:2) }
  let(:student) { create(:student, enrollment_status:enrollment_status_applicant) }

  describe 'when select admission period', js: true do
    context 'without methods' do

      before do
        admission_period_no_methods
        visit gaku.admin_admissions_path
        select "#{admission_period_no_methods.name}", from: 'admission_period_id'
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

        it 'doesn\'t renames listing buttons on changing period' do # this was issue
          select "#{admission_period.name}", from: 'admission_period_id'
          wait_for_ajax
          within('#admissions_links') do
            page.should have_content 'Applicants List'
            page.should have_content 'Listing Admissions'
          end
        end

      end

      context 'url changes' do

        before do
          admission_period_no_methods
          visit gaku.admin_admissions_path
        end

        it 'sets parameters in the url' do
          select "#{admission_period.name}", from: 'admission_period_id'
          wait_for_ajax
          check_path(current_url,"/admin/admissions?admission_method_id=1&amp;admission_period_id=#{admission_period.id}")
          page.evaluate_script('window.history.back()')
          check_path(current_url,"/admin/admissions?")
        end

        it 'remembers the url even if back btn is selected' do # this was an issue
          select "#{admission_period.name}", from: 'admission_period_id'
          select "#{admission_period_no_methods.name}", from: 'admission_period_id'
          wait_for_ajax
          check_path(current_url,"/admin/admissions?admission_period_id=#{admission_period_no_methods.id}")
          select "#{admission_period.name}", from: 'admission_period_id'
          wait_for_ajax
          check_path(current_url,"/admin/admissions?admission_method_id=#{admission_period.admission_methods.first.id}&amp;admission_period_id=#{admission_period.id}")
          page.evaluate_script('window.history.back()')
          check_path(current_url,"/admin/admissions?admission_period_id=#{admission_period_no_methods.id}")
          wait_for_ajax
          click_on 'Listing Admissions'
          check_path(current_url,"/admin/admissions/listing_admissions?admission_period_id=#{admission_period_no_methods.id}")
        end

      end

      context 'when change method' do

        before do
          select "#{admission_period.name}", from: 'admission_period_id'
          wait_for_ajax
          within('#admission-method-selection') { select "#{@last_method.name}", from: 'admission_method_id' }
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

        it 'doesn\'t renames listing buttons on changing method' do # this was an issue
          select "#{admission_period.admission_methods.last.name}", from: 'admission_method_id'
          wait_for_ajax
          within('#admissions_links') do
            page.should have_content 'Applicants List'
            page.should have_content 'Listing Admissions'
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
                #wait_until { page.should_not have_css('#student-modal') }
              end
            end.to change(Gaku::Admission, :count).by 1

            within ('#state1' ) do
              within('#students-index') { page.should have_content ("#{student.name}") }
            end
          end

        end

        context 'Journey - add new student and', js:true do

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

          it 'change state and grade exam' do
            #Exam | Pre Exam
            within("#state#{@first_method.admission_phases.first.admission_phase_states.first.id}") do
              find(:css, "#student-1-check").set(true)
              select "Abscent", from: 'state_id'
              click_on 'Save'
              wait_for_ajax
              sleep 1
              wait_until { size_of("#students-index tbody tr").should eq 0 }
              page.should_not have_content 'Admitted on'
            end
            page.should have_content "Interview(0)"
            #Exam | Abscent
            within("#state#{@first_method.admission_phases.first.admission_phase_states.last.id}") do
              size_of("#students-index tbody tr").should eq 1
              find(:css, "#student-1-check").set(true)
              select "Passed", from: 'state_id'
              click_on 'Save'
              sleep 1
              wait_until { size_of("#students-index tbody tr").should eq 0 }
            end
            #grade exam
            page.should have_content 'Grade Exam'
            click_on 'Grade Exam'
            fill_in 'portion_score', with: 89
            click '.exam-parts' #TODO fix this
            sleep 1
            visit gaku.admin_admissions_path
            #Exam | Passed
            within("#state#{@first_method.admission_phases.first.admission_phase_states.third.id}") do
              size_of("#students-index tbody tr").should eq 1
              page.should_not have_content 'Admitted on'
              click_on 'Save'
              sleep 1
            end
            page.should have_content "Interview(1)"
            click_on "Interview(1)"
            page.should have_content 'Marta'
            #Interview | Waiting for Interview
            within("#state#{@first_method.admission_phases.last.admission_phase_states.first.id}") do
              size_of("#students-index tbody tr").should eq 1
              page.should_not have_content 'Admitted on'
              find(:css, "#student-1-check").set(true)
              select "Accepted", from: 'state_id'
              click_on 'Save'
              sleep 1
            end
            #Interview | Accepted
            within("#state#{@first_method.admission_phases.last.admission_phase_states.third.id}") do
              size_of("#students-index tbody tr").should eq 1
              page.should have_content 'Admitted On'
            end
            #TODO revert admitted if admitted by mistake
            visit gaku.students_path
            select "Admitted", from: 'q[enrollment_status_id_eq]'
            page.should have_content 'Marta'
            page.should have_content 'Admitted On'
          end

          context 'exports' do
          end
        end

      end

    end

  end
end
