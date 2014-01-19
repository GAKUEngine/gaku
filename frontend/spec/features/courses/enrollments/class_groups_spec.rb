require 'spec_helper'

describe 'CourseEnrollment'  do

  before { as :admin }

  let(:course) { create(:course) }
  let(:class_group) { create(:class_group, name: 'Math') }
  let(:class_group_with_students) { create(:class_group, :with_students, name: 'Math') }

  before :all do
    set_resource 'course-class-group'
  end

  context 'no existing class group', js: true do
    before do
      visit gaku.edit_course_path(course)
      click new_link

    end

    it 'errors if no class_group is selected' do
      click submit
      page.should have_content 'No Class Group selected'
    end

  end

  context 'empty class group', js: true do
    it 'errors if class group is empty' do
      class_group
      visit gaku.edit_course_path(course)

      click new_link

      select 'Math', from: 'course_class_group_id'
      click submit

      page.should have_content 'Class Group is empty'
    end
  end

  context 'class group with 2 students', js: true do
    before do
      class_group_with_students
      visit gaku.edit_course_path(course)
    end

    it 'enrolls a class group' do
        click new_link

      expect do
        select 'Math', from: 'course_class_group_id'
        click submit

        page.should have_content class_group_with_students.students.first
        page.should have_content class_group_with_students.students.second
        page.should have_content 'View Assignments'
        page.should have_content 'View Exams'
      end.to change(course.students, :count).by 2

      # TODO show flash msgs for successfuly added students
    end

    it 'errors if all students are already added' do
      class_group_with_students.students.each do |student|
        course.students << student
      end
      visit gaku.edit_course_path(course)

      click new_link

      visible?(form)
      select 'Math', from: 'course_class_group_id'
      click submit

      page.should have_content 'are already added'
    end

  end
end
