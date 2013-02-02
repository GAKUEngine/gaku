require 'spec_helper'

describe 'ExtracurricularActivity Students' do

  stub_authorization!

  let(:extracurricular_activity) { create(:extracurricular_activity) }
  let(:student1) { create(:student, :name => 'Susumu', :surname => 'Yokota') }
  let(:student2) { create(:student) }
  let(:student3) { create(:student) }

  before :all do
    set_resource "extracurricular-activity-student"
  end

  before do
    extracurricular_activity
  end

  context "#new", js: true do
    before do
      student1
      student2
      student3
      visit gaku.extracurricular_activities_path
      click show_link
      click_link 'extracurricular-activity-enrollments-tab-link'
      Gaku::ExtracurricularActivityEnrollment.count.should eq 0
      click new_link
      wait_until_visible('#student-modal')
    end

    it 'adds and shows a student' do
      expect do
        enroll_one_student_via_button 'Enroll to Extracurricular Activity'
      end.to change(Gaku::ExtracurricularActivityEnrollment,:count).by 1

      page.should have_content "#{student1} : Successfully enrolled!"
      within('.extracurricular-activity-enrollments-count') { page.should have_content "1" }
      within('#extracurricular-activity-enrollments-tab-link') { page.should have_content "1" }
    end

    it 'adds more than one student' do
      expect do
        enroll_three_students_via_button 'Enroll to Extracurricular Activity'
      end.to change(Gaku::ExtracurricularActivityEnrollment,:count).by 3

      page.should have_content "#{student1} : Successfully enrolled!"
      page.should have_content "#{student2} : Successfully enrolled!"
      page.should have_content "#{student3} : Successfully enrolled!"
      within('.extracurricular-activity-enrollments-count') { page.should have_content "3" }
      within('#extracurricular-activity-enrollments-tab-link') { page.should have_content "3" }

    end

    it 'cancels adding' do
      click cancel_link
      wait_until_invisible('#student-modal')
    end
  end

  context "#search " do
    it 'searches students', :js => true do
      visit gaku.extracurricular_activities_path
      click show_link
      click_link 'extracurricular-activity-enrollments-tab-link'

      create(:student, :name => 'Kenji', :surname => 'Kita')
      create(:student, :name => 'Chikuhei', :surname => 'Nakajima')

      click new_link
      wait_until_visible('#student-modal')
      size_of(table_rows) == 3
      fill_in 'q[name_cont]', :with => 'Sus'
      wait_until { size_of(table_rows) == 1 }
    end
  end

  context "when student is already added" do
    before do
      extracurricular_activity.students << student1
      visit gaku.extracurricular_activity_path(extracurricular_activity)
      within('.extracurricular-activity-enrollments-count') { page.should have_content "1" }
      within('#extracurricular-activity-enrollments-tab-link') { page.should have_content "1" }
      Gaku::ExtracurricularActivityEnrollment.count.should eq 1
    end

    it 'enrolls student only once', :js => true do
      click new_link
      wait_until { page.find('#student-modal').visible? }
      within('tr#student-' + student1.id.to_s) do
        page.should have_selector("img.enrolled")
      end
    end

    it 'deletes', :js => true do
      click_link 'extracurricular-activity-enrollments-tab-link'

      ensure_delete_is_working

      within('.extracurricular-activity-enrollments-count') { page.should_not have_content("1") }
      within('#extracurricular-activity-enrollments-tab-link') { page.should_not have_content("1") }
    end
  end

  it 'errors is student is enrolled meanwhile', :js => true do
    student1

    visit gaku.extracurricular_activity_path(extracurricular_activity)
    click new_link
    wait_until { page.find('#student-modal').visible? }
    extracurricular_activity.students << student1
    enroll_one_student_via_button 'Enroll to Extracurricular Activity'
    wait_until_invisible('#student-modal')
    page.should have_content "#{student1} : Student Already enrolled to the extracurricular activity!"
  end

end
