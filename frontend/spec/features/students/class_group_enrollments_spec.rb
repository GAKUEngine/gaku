require 'spec_helper'

describe 'Student class group enrollment' do

  before(:all) { set_resource 'student-class-group-enrollment' }
  before { as :admin }

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:class_group) { create(:class_group) }
  let(:class_group_enrollment) { create(:class_group_enrollment, student: student, enrollmentable: class_group) }

  context 'new', js: true do

    before do
      class_group
      visit gaku.edit_student_path(student)
      click '#student-class-groups-menu a'
      click new_link
    end

    it 'creates' do
      expect do
        expect do
          select class_group.name, from: 'enrollment_enrollmentable_id'
          click submit
          within(table) { has_content? class_group.name }
        end.to change(Gaku::Enrollment, :count).by(1)
      end.to change(student.class_group_enrollments, :count).by(1)

      flash_created?
      within(table) { has_content? class_group.name }
      within('.class-groups-count') { expect(page.has_content?('1')).to eq true }

      count? 'Class Groups list(1)'
    end

    it { has_validations? }
  end

  context 'existing',  js: true do
    before do
      class_group
      class_group_enrollment
      visit gaku.edit_student_path(student)
      click '#student-class-groups-menu a'
    end


    it 'deletes' do
      has_content? class_group.name
      count? 'Class Groups list(1)'
      expect do
        ensure_delete_is_working
        within(table) { has_no_content? class_group.name }
      end.to change(Gaku::Enrollment, :count).by(-1)

      flash_destroyed?
      count? 'Class Groups list'
      within('.class-groups-count') { expect(page.has_content?('0')).to eq true }


    end
  end
end
