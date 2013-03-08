require 'spec_helper'
require 'support/requests/course_enrollable_spec'

describe 'ClassGroup Courses' do

  as_admin

  let(:class_group) { create(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1') }
  let(:course) { create(:course, :code => 'Math2012') }

  before :all do
    set_resource "class-group-course"
  end

  context 'new', :js => true do
    before do
      @course = course
      visit gaku.class_group_path(class_group)
      @data = class_group
      @select = 'class_group_course_enrollment_course_id'
    end

    it_behaves_like 'enroll to course'
  end

  context 'remove' do
    
    before do
      class_group.courses << course
      visit gaku.class_group_path(class_group)
      @data = class_group

      click tab_link
    end

    it_behaves_like 'remove enrollment'
  end
  
end
