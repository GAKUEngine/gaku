require 'spec_helper'

describe 'Courses' do


  table_rows = '#courses-index tbody tr'
  count_div = '.courses-count'

  stub_authorization!

  before do
    @syllabus = create(:syllabus, :name => 'biology2012', :code => 'bio')
    visit courses_path
  end
  
  context 'new' do 
    before do 
      click "#new-course-link"
      wait_until_visible '#submit-course-button' 
    end

    it "create new course", :js => true do
      tr_count = page.all(table_rows).size

      expect do      
        fill_in 'course_code', :with => 'SUMMER2012'
        select "#{@syllabus.name}", :from => 'course_syllabus_id'
        click '#submit-course-button'
      end.to change(Course, :count).by(1)


      within(count_div) { page.should have_content('Courses List(1)') }
      wait_until_invisible '#new-course'
      
      flash_created?
      
      within('#courses-index') { page.should have_content(@syllabus.name) }
      
      wait_until { page.all(table_rows).size == tr_count + 1 }
    end

    it 'should cancel creating', :js => true do
      click '#cancel-course-link'
      wait_until_invisible '#new-course'

      click "#new-course-link"
      wait_until_visible '#new-course'
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

    it "should edit a course from show", :js => true do
      within('#courses-index tbody tr') { find(".show-link").click }
      page.should have_content("Show")
      
      find('.edit-link').click
      wait_until { find('#course-modal').visible? }
      
      page.should have_content("Edit Course") 
      fill_in 'course_code', :with => 'biology2013'
      page.select "biology2013Syllabus", :from => 'course_syllabus_id'
      click_button 'submit-course-button'

      flash_updated?
      page.should have_content "biology2013Syllabus"
      page.should have_content "biology2013"
    end

    it "should delete a course", :js => true do
      tr_count = page.all(table_rows).size
      within(count_div) { page.should have_content('Courses List(1)') }
      page.should have_content(@course.code)
      
      expect do     
        within('table#courses-index tbody tr') { click ".delete-link" }
        page.driver.browser.switch_to.alert.accept
        wait_until { page.all(table_rows).size == tr_count - 1 }
      end.to change(Course, :count).by(-1)
      
      flash_destroyed?
      within(count_div) { page.should_not have_content('Courses List(1)') }
      page.should_not have_content(@course.code)
    end
  end
end