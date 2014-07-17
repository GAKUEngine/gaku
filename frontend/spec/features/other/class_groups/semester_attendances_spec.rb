require 'spec_helper'

describe 'ClassGroup Semester Attendances' do

  before { as :admin }

  let!(:class_group) { create(:class_group) }
  let!(:student) { create(:student) }
  let!(:student2) { create(:student) }
  let!(:enrollment) { create(:class_group_enrollment, enrollmentable: class_group, student: student) }
  let!(:enrollment2) { create(:class_group_enrollment, enrollmentable: class_group, student: student2) }
  let!(:semester) { create(:active_semester) }
  let!(:semester_connector) { create(:semester_connector_class_group, semester: semester, semesterable: class_group) }
  let(:semester_attendance) { create(:semester_attendance, student: student, semester: semester, days_absent: 51, days_present: 69)}

  context 'index', js: true do
    before do
      visit gaku.edit_class_group_path(class_group)
      click '#semester-attendances-menu a'
    end

    it 'initialize new semster attendance or check if exist' do
      expect do
        within('#ajax-load') do
          has_content?(semester.to_s)
        end
      end.to change(Gaku::SemesterAttendance, :count).by(2)
    end

  end

  context 'existing', js: true, type: 'note'  do
    before do
      semester_attendance
      visit gaku.edit_class_group_path(class_group)
    end

    it 'update' do
      click '#semester-attendances-menu a'
      within('#ajax-load') do
        has_content? 51
        has_content? 69
        expect do
        fill_in "semester-#{semester_attendance.semester_id}-student-#{semester_attendance.student_id}-days-present", with: 33
        find("#semester-#{semester_attendance.semester_id}-student-#{semester_attendance.student_id}-days-present").native.send_keys(:return)
        has_content? 33
        semester_attendance.reload
      end.to change(semester_attendance, :days_present).from(69).to(33)
      end
    end
  end
end
