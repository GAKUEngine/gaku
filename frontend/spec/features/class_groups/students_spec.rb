require 'spec_helper'

describe 'ClassGroup Students' do

  before { as :admin }

  let(:enrollment_status_applicant) { create(:enrollment_status_applicant) }
  let(:enrollment_status_admitted) { create(:enrollment_status_admitted) }
  let(:enrollment_status) { create(:enrollment_status) }
  let(:class_group) { create(:class_group, grade: '1', name: 'Biology', homeroom: 'A1') }
  let(:student1) { create(:student, name: 'Susumu', surname: 'Yokota', enrollment_status_code: enrollment_status_admitted.code) }

  before :all do
    set_resource 'class-group-student'
    Capybara.javascript_driver = :selenium
  end

  before do
    class_group
    enrollment_status_applicant
    enrollment_status_admitted
    enrollment_status
  end

  context '#new' do
    before do
      student1

      visit gaku.class_groups_path
      click edit_link
      click_link 'class-group-enrollments-tab-link'
      Gaku::ClassGroupEnrollment.count.should eq 0
      click new_link
      visible?('#student-modal')
    end

    it 'adds and shows a student', js: true do
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

          click_button 'Enroll to class'
        end
        invisible? '#student-modal'
        within(table) { page.has_content? "#{student1.name}" }
      end.to change(Gaku::ClassGroupEnrollment,:count).by 1

      page.should have_content "#{student1} : Successfully enrolled!"
      within('.class-group-enrollments-count'){ page.should have_content('1') }
      within('#class-group-enrollments-tab-link'){ page.should have_content('1') }
    end
  end

  context 'when student is added' do
    before do
      class_group.students << student1
      visit gaku.edit_class_group_path(class_group)
      within('.class-group-enrollments-count'){ page.should have_content('1') }
      within('#class-group-enrollments-tab-link'){ page.should have_content('1') }
      Gaku::ClassGroupEnrollment.count.should eq 1
    end

    it 'enrolls student only once', js: true do
      click new_link
      page.find('#student-modal').visible?
      within('tr#student-' + student1.id.to_s) do
        page.should have_selector('img.enrolled')
      end
    end

    it 'deletes', js: true do
      click_link 'class-group-enrollments-tab-link'

      ensure_delete_is_working

      within('.class-group-enrollments-count') { page.should_not have_content('1') }
      within('#class-group-enrollments-tab-link') { page.should_not have_content('1') }
    end
  end

end
