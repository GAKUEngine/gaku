require 'spec_helper'

describe 'Courses' do
  stub_authorization!

  before do
    @syllabus = create(:syllabus, :name => 'biology2012', :code => 'bio')
    visit courses_path
  end
  
  context 'new' do 
    before do 
      click_link "new-course-link"
      wait_until { find('#new-course').visible? }
    end

    it "create new course", :js => true do
      Course.count.should eq 0 
      
      fill_in 'course_code', :with => 'SUMMER2012'
      select "#{@syllabus.name}", :from => 'course_syllabus_id'
      click_button 'submit-course-button'

      wait_until { !page.find('#new-course').visible? }
      page.should have_content "was successfully created"
      page.should have_content("#{@syllabus.name}")
      Course.count.should eq 1 
    end

    it 'should cancel creating', :js => true do
      click_link 'cancel-course-link'
      wait_until { !page.find('#new-course').visible? }

      click_link "new-course-link"
      wait_until { find('#new-course').visible? }
    end

    pending 'not create without required fields'

  end

  context "existing course" do
    before do
      @syllabus2 = create(:syllabus, :name => 'biology2013Syllabus', :code => 'biology')
      @course = create(:course, :syllabus => @syllabus) 
      visit courses_path
    end

    it "should list and show existing courses" do
      within("#courses-index") { page.should have_content("biology") }
      within('#courses-index tbody tr') { find(".show-link").click }
      
      page.should have_content('Course Code')
      page.should have_content('biology')
    end

    it "should edit a course", :js => true  do
      within('#courses-index tbody tr') { find(".edit-link").click }

      page.should have_content("Edit Course") 
      fill_in 'course_code', :with => 'biology2013'
      page.select "biology2013Syllabus", :from => 'course_syllabus_id'
      click_button 'submit-course-button'

      page.should have_content "biology2013Syllabus"
      page.should have_content "biology2013"
    end

    it "should edit a course from show" do
      within('#courses-index tbody tr') { find(".show-link").click }
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

    it "should delete a course", :js => true do
      @syllabus.courses.count.should eq 1
      page.should have_content("Courses list")
      page.should have_content(@course.code)
      tr_count = page.all('table#courses-index tbody tr').size
      
      within('table#courses-index tbody tr') { find(".delete-link").click }
      page.driver.browser.switch_to.alert.accept

      wait_until { page.all('table#courses-index tbody tr').size == tr_count - 1 }
      page.should_not have_content(@course.code)
      @syllabus.courses.count.should eq 0
    end
  end
end