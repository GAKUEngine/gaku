require 'spec_helper'

describe 'Course Enrollments' do

  before { as :admin }

  let(:course) { create(:course) }
  let(:student) { create(:student) }

  let(:course_enrollment) do
    create(:course_enrollment, student: student, enrollmentable: course)
  end

  before :all do
    set_resource 'course-enrollment'
  end

  before do
    course
  end

  context 'new', js: true do
    before do
      student
      visit gaku.edit_course_path(course)
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
      within(count_div) { expect(page).to have_content 'Students list(1)' }
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
      course_enrollment
      visit gaku.edit_course_path(course)
      click '#students-menu a'
    end

    # context 'edit', js: true do
    #   before do
    #     within(table) { click js_edit_link }
    #     visible? modal
    #   end

    #   it 'edits' do
    #     select "#{semester2.starting} / #{semester2.ending}", from: 'semester_connector_semester_id'
    #     click submit

    #     flash_updated?
    #     within(table) { expect(page).to have_content "#{semester2.starting} / #{semester2.ending}" }
    #     within(table) { expect(page).to_not have_content "#{semester.starting} / #{semester.ending}" }
    #   end

    # end

    it 'delete', js: true do
      within(table) { expect(page).to have_content course_enrollment.student.surname }
      within(table) { expect(page).to have_content course_enrollment.student.name }
      has_content? 'Students list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::Enrollment, :count).by(-1)

      within(table) { has_no_content? course_enrollment.student.surname }
      within(table) { has_no_content? course_enrollment.student.name }
      has_no_content? 'Students list(1)'
    end
  end
end
