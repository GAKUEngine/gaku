require 'spec_helper'

describe 'ClassGroup Courses' do
  stub_authorization!
  
  before do
    @class_group = Factory(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
    @course = Factory(:course, :code => 'Math2012')
    visit class_group_path(@class_group)
    click_link 'class-group-courses-tab-link'
  end

  it 'should add and show course to a class group', :js => true do
    ClassGroupCourseEnrollment.count.should eql(0)
    tr_count = page.all('#courses-index tbody tr').size
    click_link 'new-class-group-course-link'
    wait_until { page.find('#new-class-group-course-form').visible? }
    select "#{@course.code}", :from => 'class_group_course_enrollment_course_id'
    click_button 'submit-course-button'

    wait_until { page.all('#courses-index tbody tr').size == tr_count + 1 }
    within("#courses-index tbody"){ page.should have_content ("#{@course.code}") }
    within(".courses-count"){ page.should have_content("1") }
    within('#class-group-courses-tab-link'){ page.should have_content("1") }
    ClassGroupCourseEnrollment.count.should eql(1)
  end

  it 'should not add a course if course code is empty', :js => true do
    click_link 'new-class-group-course-link'
    wait_until { page.find('#new-class-group-course-form').visible? }
    click_button 'submit-course-button'

    wait_until { page.has_content?('Course can\'t be blank') }
  end

  it 'should not add a course if cancel btn is selected', :js => true do
    click_link 'new-class-group-course-link'
    wait_until { page.find('#new-class-group-course-form').visible? }
    click_on 'cancel-course-link'
    wait_until { !page.find('#new-class-group-course-form').visible? }
    within("#courses-index tbody"){ page.should_not have_content ("#{@course.code}") }
    ClassGroupCourseEnrollment.count.should eql(0)
    @class_group.courses.count.should eql(0)
  end

  context 'Class group with added course' do
    before do
      @class_group.courses << @course
      visit class_group_path(@class_group)
      click_link 'class-group-courses-tab-link'

      within(".courses-count") { page.should have_content("1") }
      within('#class-group-courses-tab-link') { page.should have_content("1") }
    end

    it 'should not add a course if it is already added', :js => true do  
      click_link 'new-class-group-course-link'
      wait_until { page.find('#new-class-group-course-form').visible? }
      select "#{@course.code}", :from => 'class_group_course_enrollment_course_id'
      click_button 'submit-course-button'

      wait_until { page.should have_content("Course Already enrolled to the class group!") }
      
    end

    it 'should delete a course from class group', :js => true do  
      ClassGroupCourseEnrollment.count.should eql(1)
      @class_group.courses.count.should eql(1)
      page.all('#courses-index tbody tr').size.should eql(1)
      within("#courses-index tbody") do
        page.should have_content ("#{@course.code}")
        find(".delete-link").click
      end
      page.driver.browser.switch_to.alert.accept
      
      within("#courses-index tbody"){ page.should_not have_content("#{@course.code}") }
      within(".courses-count"){ page.should_not have_content("1") }
      within('#class-group-courses-tab-link'){ page.should_not have_content("1") }
      ClassGroupCourseEnrollment.count.should eql(0)
      @class_group.courses.count.should eql(0)
    end
  end

end
