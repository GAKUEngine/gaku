require 'spec_helper'

describe 'CourseGroup Courses' do
  stub_authorization!

  let(:course_group) { create(:course_group, :name => "math 2012 courses") }
  let(:course) { create(:course, :code => 'Math2012') }

  before :all do
    set_resource "course-group-enrollment"
  end

  context 'new', :js => true do
    before do
      course
      visit gaku.course_group_path(course_group)
      click new_link
      wait_until_visible submit
    end

    it 'adds and shows' do
      expect do
        select "#{course.code}", :from => 'course_group_enrollment_course_id'
        click submit
        wait_until_invisible form
      end.to change(Gaku::CourseGroupEnrollment, :count).by 1

      within(table) { page.should have_content "#{course.code}" }
      page.should have_content "Courses list(1)"
      page.has_content? 'Course added to course group'

    end

    it 'errors without required fields' do
      click submit
      wait_until { page.has_content? 'Course can\'t be blank' }
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing', :js => true do
    before do
      course_group.courses << course
      visit gaku.course_group_path(course_group)
      page.should have_content "Courses list(1)"
    end

    it 'doesn\'t add a course 2 times' do
      click new_link
      wait_until_visible form
      select "#{course.code}", :from => 'course_group_enrollment_course_id'
      click submit
      wait_until { page.should have_content "Course already enrolled to this course group!" }
    end

    it 'deletes' do

      within(table) { page.should have_content "#{course.code}" }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::CourseGroupEnrollment, :count).by -1

      within(table) { page.should_not have_content "#{course.code}" }
      page.should_not have_content "Courses list(1)"

      flash_destroyed?
    end
  end

end
