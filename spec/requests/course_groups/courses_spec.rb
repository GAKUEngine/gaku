require 'spec_helper'

describe 'CourseGroup Courses' do
  stub_authorization!
  
  before do
    @course_group = create(:course_group, :name => "math 2012 courses")
    @course = create(:course, :code => 'Math2012')
    visit course_group_path(@course_group)
  end

  it 'should add and show course to a course group', :js => true do
    CourseGroupEnrollment.count.should eql(0)
    tr_count = page.all('#course-group-enrollments-index tbody tr').size
    click_link 'new-course-group-enrollment-link'

    wait_until { page.find('#new-course-group-enrollment-form').visible? }
    select "#{@course.code}", :from => 'course_group_enrollment_course_id'
    click_button 'submit-course-group-enrollment-button'

    wait_until { page.all('#course-group-enrollments-index tbody tr').size == tr_count+1 }
    within("#course-group-enrollments-index tbody") { page.should have_content ("#{@course.code}") }
    within('.course-group-enrollments-count') { page.should have_content('1') }
    CourseGroupEnrollment.count.should eql(1)

  end

  it 'should not add a course if course code is empty', :js => true do
    click_link 'new-course-group-enrollment-link'
    wait_until { page.find('#new-course-group-enrollment-form').visible? }
    click_button 'submit-course-group-enrollment-button'

    wait_until { page.has_content?('Course can\'t be blank') }
  end

  it 'add a new course / cancel', :js => true do
    tr_count = page.all('#course-group-enrollments-index tbody tr').size
    click_link 'new-course-group-enrollment-link'
    wait_until { page.find('#new-course-group-enrollment-form').visible? }
    select "#{@course.code}", :from => 'course_group_enrollment_course_id'
    click_link 'course-group-enrollment-cancel-link'

    page.all('#course-group-enrollments-index tbody tr').size.should == tr_count

    within("#course-group-enrollments-index tbody") { page.should_not have_content ("#{@course.code}") }
    CourseGroupEnrollment.count.should eql(tr_count)
  end

  context 'Course group with added course' do
    before do
      @course_group.courses << @course
      visit course_group_path(@course_group)
    end

    it 'should not add a course if it is already added', :js => true do  
      click_link 'new-course-group-enrollment-link'
      wait_until { page.find('#new-course-group-enrollment-form').visible? }
      select "#{@course.code}", :from => 'course_group_enrollment_course_id'
      click_button 'submit-course-group-enrollment-button'

      wait_until { page.should have_content("Course already enrolled to this course group!") }
    end

    it 'should delete a course from course group', :js => true do  
      CourseGroupEnrollment.count.should eql(1)
      @course_group.courses.count.should eql(1)
      page.all('#course-group-enrollments-index tbody tr').size.should eql(1)
      within('.course-group-enrollments-count') { page.should have_content('1') }
      within("#course-group-enrollments-index tbody") { page.should have_content ("#{@course.code}") }
        
      find('.delete-link').click
      page.driver.browser.switch_to.alert.accept
      
      within("#course-group-enrollments-index tbody") { page.should_not have_content("#{@course.code}") }
      CourseGroupEnrollment.count.should eql(0)
      @course_group.courses.count.should eql(0)
    end
  end

end