require 'spec_helper'

describe 'Courses' do
  before do
    @course = Factory(:course, :code => 'bio')
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Courses"}
    @syllabus = Factory(:syllabus)
  end

  context "listing courses" do
    pending "should list existing courses" do
      page.should have_content("Courses List")
      within('table.index tr:nth-child(2)') { page.should have_content("bio") }
      
      # show
      #within('table.index tr:nth-child(2)') { click_link "Show" }

      #TODO Make a real check when view is finished
      #page.should have_content("Course")
      #page.should have_content("bio")

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