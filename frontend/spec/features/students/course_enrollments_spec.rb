require 'spec_helper'

describe 'Student course enrollment' do

  before(:all) { set_resource 'student-course-enrollment' }
  before { as :admin }

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:course) { create(:course) }
  let(:course_enrollment) { create(:course_enrollment, student: student, enrollmentable: course) }

  context 'new', js: true do

    before do
      course
      visit gaku.edit_student_path(student)
      click '#student-courses-menu a'
      click new_link
    end

    it 'creates' do
      expect do
        expect do
          select course.code, from: 'enrollment_enrollmentable_id'
          click submit
          within(table) { has_content? course.code }
        end.to change(Gaku::Enrollment, :count).by(1)
      end.to change(student.course_enrollments, :count).by(1)

      within(table) { has_content? course.code }
      within('.courses-count') { expect(page.has_content?('1')).to eq true }

      count? 'Courses list(1)'
    end

    it { has_validations? }
  end

  context 'existing',  js: true do
    before do
      course
      course_enrollment
      visit gaku.edit_student_path(student)
      click '#student-courses-menu a'
    end


    it 'deletes' do
      has_content? course.code
      count? 'Courses list(1)'
      expect do
        ensure_delete_is_working
        within(table) { has_no_content? course.code }
      end.to change(Gaku::Enrollment, :count).by(-1)

      count? 'Courses list'
      within('.courses-count') { expect(page.has_content?('0')).to eq true }


    end
  end
end
