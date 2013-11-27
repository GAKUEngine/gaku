require 'spec_helper'

describe 'ExtracurricularActivity Students' do

  before(:all) do
    Capybara.javascript_driver = :selenium
    set_resource 'extracurricular-activity-student'
  end

  before { as :admin }

  let(:enrollment_status_applicant) { create(:enrollment_status_applicant) }
  let(:enrollment_status_admitted) { create(:enrollment_status_admitted) }
  let(:enrollment_status) { create(:enrollment_status) }
  let(:extracurricular_activity) { create(:extracurricular_activity) }
  let(:student1) { create(:student, name: 'Susumu', surname: 'Yokota', enrollment_status_code: enrollment_status_admitted.code) }
  let(:student2) { create(:student, enrollment_status_code: enrollment_status_admitted.code) }
  let(:student3) { create(:student, enrollment_status_code: enrollment_status_admitted.code) }

  before do
    extracurricular_activity
    enrollment_status_applicant
    enrollment_status_admitted
    enrollment_status
  end

  context 'new student', js: true do
    before do
      student1
      student2
      student3
      visit gaku.extracurricular_activities_path
      click edit_link
      click_link 'extracurricular-activity-enrollments-tab-link'
      Gaku::ExtracurricularActivityEnrollment.count.should eq 0
      click new_link
      visible? '#student-modal'
    end

    it 'adds and shows a student' do
      expect do
        find(:css, "input#student-#{student1.id}").set(true)
        visible? '#students-checked-div'
        within('#students-checked-div') do
          page.has_content? 'Chosen students'

          within('.show-chosen-table') do
            page.has_content? 'Show'
            click_link 'Show'
          end

          page.has_selector? '#chosen-table'
          page.has_selector? '#students-checked'
          within('#students-checked') { page.has_content? "#{student1.name}" }

          click_button 'Enroll to Extracurricular Activity'
        end
        invisible? '#student-modal'
        within(table) { page.has_content? "#{student1.name}" }
      end.to change(Gaku::ExtracurricularActivityEnrollment,:count).by 1

      page.should have_content "#{student1} : Successfully enrolled!"
      within('.extracurricular-activity-enrollments-count') { page.should have_content '1' }
      within('#extracurricular-activity-enrollments-tab-link') { page.should have_content '1' }
    end

    it 'adds more than one student' do
      expect do
        find(:css, "input#student-#{student1.id}").set(true)
        find(:css, "input#student-#{student2.id}").set(true)
        find(:css, "input#student-#{student3.id}").set(true)

        visible? '#students-checked-div'
        within('#students-checked-div') do
          page.should have_content 'Chosen students'
          click_link 'Show'
          visible? '#chosen-table'
          page.should have_content "#{student1.name}"
          page.should have_content "#{student2.name}"
          page.should have_content "#{student3.name}"
          click_button 'Enroll to Extracurricular Activity'
        end
        invisible? '#student-modal'

        within(table) do
          page.should have_content "#{student1.name}"
          page.should have_content "#{student2.name}"
          page.should have_content "#{student3.name}"
        end
      end.to change(Gaku::ExtracurricularActivityEnrollment,:count).by 3

      page.should have_content "#{student1} : Successfully enrolled!"
      page.should have_content "#{student2} : Successfully enrolled!"
      page.should have_content "#{student3} : Successfully enrolled!"
      within('.extracurricular-activity-enrollments-count') { page.should have_content '3' }
      within('#extracurricular-activity-enrollments-tab-link') { page.should have_content '3' }

    end

  end


  context 'existing student' do
    before do
      extracurricular_activity.students << student1
      visit gaku.edit_extracurricular_activity_path(extracurricular_activity)
      within('.extracurricular-activity-enrollments-count') { page.should have_content '1' }
      within('#extracurricular-activity-enrollments-tab-link') { page.should have_content '1' }
      Gaku::ExtracurricularActivityEnrollment.count.should eq 1
    end

    it 'enrolls student only once', js: true do
      click new_link
      page.find('#student-modal').visible?
      within('tr#student-' + student1.id.to_s) do
        page.should have_selector('img.enrolled')
      end
    end

    it 'deletes', js: true do
      click_link 'extracurricular-activity-enrollments-tab-link'

      ensure_delete_is_working

      within('.extracurricular-activity-enrollments-count') { page.should_not have_content('1') }
      within('#extracurricular-activity-enrollments-tab-link') { page.should_not have_content('1') }
    end
  end

  context 'if added meanwhile' do

    it 'errors is student is enrolled meanwhile', js: true do
      student1
      visit gaku.edit_extracurricular_activity_path(extracurricular_activity)
      click new_link
      page.find('#student-modal').visible?
      extracurricular_activity.students << student1

      find(:css, "input#student-#{student1.id}").set(true)
      visible? '#students-checked-div'
      within('#students-checked-div') do
        page.has_content? 'Chosen students'

        within('.show-chosen-table') do
          page.has_content? 'Show'
          click_link 'Show'
        end

        page.has_selector? '#chosen-table'
        page.has_selector? '#students-checked'
        within('#students-checked') { page.has_content? "#{student1.name}" }

        click_button 'Enroll to Extracurricular Activity'
      end
      invisible? '#student-modal'
      within(table) { page.has_content? "#{student1.name}" }

      invisible? '#student-modal'
      page.should have_content "#{student1} : Student Already enrolled to the extracurricular activity!"
    end
  end

end
