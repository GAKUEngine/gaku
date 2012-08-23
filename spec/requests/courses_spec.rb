require 'spec_helper'

describe 'Courses' do
  before do
    @syllabus = Factory(:syllabus, :name => 'biology2012', :code => 'bio')
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Course Management" }
    within('ul#menu') { click_link "Courses" }
  end

  context "creating new course" do 
    it "should create new course" do 
      click_link "new_course_link"

      fill_in 'course_code', :with => 'SUMMER2012'
      page.select "#{@syllabus.name}", :from => 'course_syllabus_id'
      click_button 'Create Course'

      page.should have_content "was successfully created"
      page.should have_content("#{@syllabus.name}")
    end
  end

  context "index, edit, delete", :js => true do

    before do
      @syllabus2 = Factory(:syllabus, :name => 'biology2013Syllabus', :code => 'biology')
      @course = Factory(:course, :syllabus => @syllabus) 
      visit courses_path
    end

    it "should list and show existing courses" do
      within(".table tbody tr td") { page.should have_content("bio") }
      within('.table tr:nth-child(2)') { click_link "show_link" }
      
      page.should have_content('Course Code')
      page.should have_content('bio')
      page.should have_content('Number Enrolled')
    end

    it "should edit a course" do
      within('.table  tr:nth-child(2)') { click_link "edit_link" }

      page.should have_content("Edit Course") 
      fill_in 'course_code', :with => 'biology2013'
      page.select "biology2013Syllabus", :from => 'course_syllabus_id'
      click_button 'Update Course'

      page.should have_content "was successfully updated"
      page.should have_content "biology2013Syllabus"
      page.should have_content "biology2013"
    end

    it "should edit a course from show" do
      within('.table  tr:nth-child(2)') { click_link "show_link" }
      page.should have_content("Show")

      click_link('Edit')
      page.should have_content("Edit Course") 
      fill_in 'course_code', :with => 'biology2013'
      page.select "biology2013Syllabus", :from => 'course_syllabus_id'
      click_button 'Update Course'

      page.should have_content "was successfully updated"
      page.should have_content "biology2013Syllabus"
      page.should have_content "biology2013"
    end

    it "should delete a course" do
      @syllabus.courses.count.should == 1
      page.should have_content("Courses List")
      page.should have_content(@course.code)

      within('.table  tr:nth-child(2)') { click_link "delete_link" }
      
      page.driver.browser.switch_to.alert.accept
      page.should_not have_content(@course.code)
      @syllabus.courses.count.should == 0
    end
  end

end