require 'spec_helper'

describe 'Courses' do
  before do
    
    @syllabus = Factory(:syllabus, :name => 'biology2012', :code => 'bio', :id => '123' )
    @course = Factory(:course, :syllabus_id =>'123')
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Course Management"}
    within('ul#menu') { click_link "Courses"}
  end

  context "listing courses", :js => true do
    it "should list existing courses" do
      page.should have_content("Courses List")
      within(".table tbody tr td"){
        page.should have_content("bio")  
      }
      
      # show
      within('.table  tr:nth-child(2)') { click_link "show_link" }
      wait_until {
        page.has_content?('Course Code')
        page.has_content?('bio')
        page.has_content?('Number Enrolled')
      }
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