require 'spec_helper'

describe 'Class Group Enrollments' do

  before { as :admin }

  let(:class_group) { create(:class_group) }
  let(:student) { create(:student) }

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
      click tab_link
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
      class_group_enrollment
      visit gaku.edit_class_group_path(class_group)
      click tab_link
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
      within(table) { expect(page).to have_content class_group_enrollment.student.surname }
      within(table) { expect(page).to have_content class_group_enrollment.student.name }
      within(tab_link)  { expect(page).to have_content 'Student enrollments(1)' }
      has_content? 'Student enrollments list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::Enrollment, :count).by -1

      within(table) { has_no_content? class_group_enrollment.student.surname }
      within(table) { has_no_content? class_group_enrollment.student.name }
      within(tab_link) { has_no_content? 'Student enrollments(1)' }
      has_no_content? 'Student enrollments list(1)'
    end
  end
end
