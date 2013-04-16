require 'spec_helper'
require 'support/requests/course_enrollable_spec'

describe 'CourseGroup Courses' do

  as_admin

  let(:course_group) { create(:course_group, :name => "math 2012 courses") }
  let(:course) { create(:course, :code => 'Math2012') }

  before :all do
    set_resource "course-group-enrollment"
  end

  context 'new', :js => true do
    before do
      @course = course
      visit gaku.course_group_path(course_group)
      @data = course_group
      @select = 'course_group_enrollment_course_id'
    end

    it_behaves_like 'enroll to course'
  end

  context 'remove' do
    
    before do
      course_group.courses << course
      visit gaku.course_group_path(course_group)
      @data = course_group

    end

    it_behaves_like 'remove enrollment'
  end

end
