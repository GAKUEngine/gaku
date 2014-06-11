require 'spec_helper'

describe 'Class Group Enrollments' do

  before { as :admin }

  let(:class_group) { create(:class_group) }
  let(:class_group2) { create(:class_group) }
  let(:student) { create(:student) }
  let(:semester) { create(:active_semester) }

  let(:class_group_enrollment) do
    create(:class_group_enrollment, student: student, enrollmentable: class_group)
  end



  before :all do
    set_resource 'class-group-enrollment'
  end

  before do
    class_group
  end

  context 'new', js: true do
    before do
      student
      visit gaku.edit_class_group_path(class_group)
      click '#students-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        select student , from: 'enrollment_student_id'
        click submit
        flash_created?
      end.to change(Gaku::Enrollment, :count).by(1)

      expect(Galu::Enrollment.last.seat_number).to eq(1)

      within(table) { expect(page).to have_content student.surname }
      within(table) { expect(page).to have_content student.name }
      within('.badge') { has_content? '1' }
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

  context 'overlapping semesters', js: true do
    before do
      student
      class_group_enrollment

      class_group.semesters << semester
      class_group2.semesters << semester

      visit gaku.edit_class_group_path(class_group2)
      click '#students-menu a'
    end

    it 'didnt create if have overlapping semesters' do
      click new_link
      expect do
        select student , from: 'enrollment_student_id'
        click submit
        has_content? 'A student cannot belong to two Class Groups with overlapping semesters'
      end.to_not change(Gaku::Enrollment, :count)
    end

  end


  context 'existing' do
    before do
      class_group_enrollment
      visit gaku.edit_class_group_path(class_group)
      click '#students-menu a'
    end


    it 'delete', js: true do
      within(table) { expect(page).to have_content class_group_enrollment.student.surname }
      within(table) { expect(page).to have_content class_group_enrollment.student.name }
      within('.badge') { has_content? '1' }
      has_content? 'Student enrollments list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::Enrollment, :count).by -1

      within(table) { has_no_content? class_group_enrollment.student.surname }
      within(table) { has_no_content? class_group_enrollment.student.name }
      within('.badge') { has_no_content? '1' }
      has_no_content? 'Students list(1)'
    end
  end
end
