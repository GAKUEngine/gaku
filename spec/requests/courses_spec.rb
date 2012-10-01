require 'spec_helper'

describe 'Courses' do
  stub_authorization!

  before do
    @syllabus = Factory(:syllabus, :name => 'biology2012', :code => 'bio')
    visit courses_path
  end

  context "creating new course" do 
    it "should create new course" do 
      click_link "new-course-link"

      fill_in 'course_code', :with => 'SUMMER2012'
      page.select "#{@syllabus.name}", :from => 'course_syllabus_id'
      click_button 'submit-course-button'

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
      within("#courses-index tbody tr td") { page.should have_content("bio") }
      within('#courses-index tr:nth-child(2)') { click_link "show-course-link" }
      
      page.should have_content('Course Code')
      page.should have_content('bio')
      page.should have_content('Number Enrolled')
    end

    it "should edit a course" do
      within('#courses-index tr:nth-child(2)') { find(".edit-link").click }

      page.should have_content("Edit Course") 
      fill_in 'course_code', :with => 'biology2013'
      page.select "biology2013Syllabus", :from => 'course_syllabus_id'
      click_button 'submit-course-button'

      page.should have_content "was successfully updated"
      page.should have_content "biology2013Syllabus"
      page.should have_content "biology2013"
    end

    it "should edit a course from show" do
      within('#courses-index  tr:nth-child(2)') { find(".show-link").click }
      page.should have_content("Show")
      
      find('.edit-link').click
      page.should have_content("Edit Course") 
      fill_in 'course_code', :with => 'biology2013'
      page.select "biology2013Syllabus", :from => 'course_syllabus_id'
      click_button 'submit-course-button'

      page.should have_content "was successfully updated"
      page.should have_content "biology2013Syllabus"
      page.should have_content "biology2013"
    end

    it "should delete a course" do
      @syllabus.courses.count.should eql(1)
      page.should have_content("Courses list")
      page.should have_content(@course.code)
      tr_count = page.all('table#courses-index tr').size
      
      within('table#courses-index tr:nth-child(2)') { find(".delete-link").click }
      page.driver.browser.switch_to.alert.accept

      wait_until { page.all('table#courses-index tr').size == tr_count - 1 }
      page.should_not have_content(@course.code)
      @syllabus.courses.count.should eql(0)
    end
  end

end