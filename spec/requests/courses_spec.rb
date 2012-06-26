require 'spec_helper'

describe 'Courses' do
  before do
    @course = Factory(:course)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Course List"}
  end

  context "listing courses" do
    it "should list existing courses" do

    end
  end

  context "creating new course" do 
    it "should create new course" do 
      click_link "new_course_link"
      #page.should have_content "was successfully created"

    end
  end
end