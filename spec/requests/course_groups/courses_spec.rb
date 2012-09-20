require 'spec_helper'

describe 'CourseGroup Courses' do
  stub_authorization!
  
  before do
    @course_group = Factory(:course_group, :name => "math 2012 courses")
    @course = Factory(:course, :code => 'Math2012')
    visit course_group_path(@course_group)
  end

  it 'should add and show course to a course group', :js => true do
    CourseGroupEnrollment.count.should == 0
    tr_count = page.all('#courses_index_table tbody tr').size
    click_link 'add_course_enrollment_link'

    wait_until { page.find('#add_course_enrollment_form').visible? }
    select "#{@course.code}", :from => 'course_group_enrollment_course_id'
    click_button 'submit_course_button'

    wait_until { page.all('#courses_index_table tbody tr').size == tr_count+1 }
    within("#courses_index_table tbody"){
      page.should have_content ("#{@course.code}")
    }
    within('.courses_count') { page.should have_content('1') }
    CourseGroupEnrollment.count.should == 1

  end

  it 'should not add a course if course code is empty', :js => true do
    click_link 'add_course_enrollment_link'
    wait_until { page.find('#add_course_enrollment_form').visible? }
    click_button 'submit_course_button'

    wait_until { page.has_content?('Course can\'t be blank') }
  end

  it 'add a new course / cancel', :js => true do
    tr_count = page.all('#courses_index_table tbody tr').size
    click_link 'add_course_enrollment_link'
    wait_until { page.find('#add_course_enrollment_form').visible? }
    select "#{@course.code}", :from => 'course_group_enrollment_course_id'
    find('#course_cancel').click

    page.all('#courses_index_table tbody tr').size.should == tr_count

    within("#courses_index_table tbody"){
      page.should_not have_content ("#{@course.code}")
    }
    CourseGroupEnrollment.count.should == tr_count
  end

  context 'Course group with added course' do
    before do
      @course_group.courses<<@course
      visit course_group_path(@course_group)
    end

    it 'should not add a course if it is already added', :js => true do  
      
      click_link 'add_course_enrollment_link'
      wait_until { page.find('#add_course_enrollment_form').visible? }
      select "#{@course.code}", :from => 'course_group_enrollment_course_id'
      click_button 'submit_course_button'

      wait_until { page.should have_content("Course already enrolled to this course group!") }
      
    end

    it 'should delete a course from course group', :js => true do  
      CourseGroupEnrollment.count.should == 1
      @course_group.courses.count.should == 1
      page.all('#courses_index_table tbody tr').size.should == 1
      within('.courses_count') { page.should have_content('1') }
      within("#courses_index_table tbody"){
        page.should have_content ("#{@course.code}")
        find('.course_group_enrollment_delete_link').click
      }
      page.driver.browser.switch_to.alert.accept
      
      within("#courses_index_table tbody"){ page.should_not have_content("#{@course.code}") }
      CourseGroupEnrollment.count.should == 0
      @course_group.courses.count.should == 0
    end
  end

end
