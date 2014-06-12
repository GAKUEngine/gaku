require 'spec_helper'

describe 'Extracurricular Activity Enrollments' do

  before { as :admin }

  let(:extracurricular_activity) { create(:extracurricular_activity) }
  let(:student) { create(:student) }

  let(:extracurricular_activity_enrollment) do
    create(:extracurricular_activity_enrollment, student: student, enrollmentable: extracurricular_activity)
  end

  before :all do
    set_resource 'extracurricular-activity-enrollment'
  end

  before do
    extracurricular_activity
  end

  context 'new', js: true do
    before do
      student
      visit gaku.edit_extracurricular_activity_path(extracurricular_activity)
      click '#students-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        select student , from: 'enrollment_student_id'
        click submit
        flash_created?
      end.to change(Gaku::Enrollment, :count).by(1)

      within(table) { expect(page).to have_content student.surname }
      within(table) { expect(page).to have_content student.name }
      within(tab_link) { expect(page).to have_content 'Student enrollments(1)' }
      within(count_div) { expect(page).to have_content 'Student enrollments list(1)' }

    end

    it 'presence validations'  do
      has_validations?
    end

    it 'uniqness scope validations'  do
      student
      expect do
        select student , from: 'enrollment_student_id'
        click submit
      end.to change(Gaku::Enrollment, :count).by(0)
      has_content?('Student already added')
    end

  end

  context 'existing' do
    before do
      extracurricular_activity_enrollment
      visit gaku.edit_extracurricular_activity_path(extracurricular_activity)
      click tab_link
    end

    it 'delete', js: true do
      within(table) { expect(page).to have_content extracurricular_activity_enrollment.student.surname }
      within(table) { expect(page).to have_content extracurricular_activity_enrollment.student.name }
      within(tab_link)  { expect(page).to have_content 'Student enrollments(1)' }
      has_content? 'Student enrollments list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::Enrollment, :count).by -1

      within(table) { has_no_content? extracurricular_activity_enrollment.student.surname }
      within(table) { has_no_content? extracurricular_activity_enrollment.student.name }
      within(tab_link) { has_no_content? 'Student enrollments(1)' }
      has_no_content? 'Student enrollments list(1)'
    end
  end
end
