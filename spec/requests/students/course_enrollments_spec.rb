require 'spec_helper'

describe 'CourseEnrollments' do
  stub_authorization!
  
  before do
    @student = create(:student)
    @course = create(:course, :code => 'fall2050')
    visit student_path(@student) 
  end

  context 'new' do 
    before do 
      click_link 'new-student-course-enrollment-tab-link'
      click_link 'new-student-course-enrollment-link'
    end

    it "should add and show student course", :js => true do\
      @student.courses.size.should eql(0)
      tr_count = page.all('table#student-course-enrollments-index tr').size

      wait_until { find('#new-student-course-enrollment form').visible? } 

      select "fall2050", :from => 'course_enrollment_course_id'
      click_button "submit-student-course-enrollment-button"
      
      wait_until { !page.find('#new-student-course-enrollment form').visible? } 
      page.should have_content("fall2050")
      page.all('table#student-course-enrollments-index tr').size == tr_count + 1
      within('.student-course-enrollments-count') { page.should have_content('Courses list(1)') }
      within('#new-student-course-enrollment-tab-link') { page.should have_content('Courses(1)') }
      @student.courses.size.should eql(1)
    end

    it 'should cancel adding', :js => true do
      wait_until { page.find('#cancel-student-course-enrollment-link').visible? } 
      click_link 'cancel-student-course-enrollment-link'
      wait_until { !page.find('#new-student-course-enrollment form').visible? } 
      find('#new-student-course-enrollment-link').visible?

      click_link 'new-student-course-enrollment-link'
      wait_until { find('#new-student-course-enrollment form').visible? } 
      !page.find('#new-student-course-enrollment-link').visible? 
    end
  end

  it "should delete a student course", :js => true do
    @student.courses << @course

    visit student_path(@student) 
    click_link 'new-student-course-enrollment-tab-link'
    wait_until { page.has_content?('Courses list') }

    tr_count = page.all('table#student-course-enrollments-index tr').size
    within('.student-course-enrollments-count') { page.should have_content('Courses list(1)') }
    within('#new-student-course-enrollment-tab-link') { page.should have_content('Courses(1)') }
    page.should have_content(@course.code)
    @student.courses.size.should eql(1)

    find('.delete-link').click 
    page.driver.browser.switch_to.alert.accept

    wait_until { page.all('table#student-course-enrollments-index tr').size == tr_count - 1 }
    within('.student-course-enrollments-count') { page.should_not have_content('Courses list(1)') }
    within('#new-student-course-enrollment-tab-link') { page.should_not have_content('Courses(1)') }
    @student.courses.size.should eql(0)
    page.should_not have_content(@course.code)
  end
  
end