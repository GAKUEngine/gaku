require 'spec_helper'

describe 'Courses' do
  before do
    @course = Factory(:course)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Course List"}
    @syllabus = Factory(:syllabus)
  end

  context "listing courses" do
    it "should list existing courses" do

    end
  end

  context "creating new course" do 
    it "should create new course" do 
      click_link "new_course_link"
      fill_in 'course_code', :with => 'SUMMER2012'
      page.select "#{@syllabus.name}", :from => 'course_syllabus_id'
      click_button 'Create Course'
      page.should have_content "was successfully created"
    end
  end
end