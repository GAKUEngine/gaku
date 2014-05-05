require 'spec_helper'

describe 'Student extracurricular activity enrollments' do

  before(:all) { set_resource 'student-extracurricular-activity-enrollment' }
  before { as :admin }

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:extracurricular_activity) { create(:extracurricular_activity) }
  let(:extracurricular_activity_enrollment) { create(:extracurricular_activity_enrollment, student: student, enrollmentable: extracurricular_activity) }

  context 'new', js: true do

    before do
      extracurricular_activity
      visit gaku.edit_student_path(student)
      click '#student-extracurricular-activities-menu a'
      click new_link
    end

    it 'creates' do
      expect do
        expect do
          select extracurricular_activity.name, from: 'enrollment_enrollmentable_id'
          click submit
          within(table) { has_content? extracurricular_activity.name }
        end.to change(Gaku::Enrollment, :count).by(1)
      end.to change(student.extracurricular_activity_enrollments, :count).by(1)

      flash_created?
      within(table) { has_content? extracurricular_activity.name }
      within('.extracurricular-activities-count') { expect(page.has_content?('1')).to eq true }

      count? 'Extracurricular Activities list(1)'
    end

    it { has_validations? }
  end

  context 'existing',  js: true do
    before do
      extracurricular_activity
      extracurricular_activity_enrollment
      visit gaku.edit_student_path(student)
      click '#student-extracurricular-activities-menu a'
    end


    it 'deletes' do
      has_content? extracurricular_activity.name
      count? 'Extracurricular Activities list(1)'
      expect do
        ensure_delete_is_working
        within(table) { has_no_content? extracurricular_activity.name }
      end.to change(Gaku::Enrollment, :count).by(-1)

      flash_destroyed?
      count? 'Extracurricular Activities list'
      within('.extracurricular-activities-count') { expect(page.has_content?('0')).to eq true }


    end
  end
end
