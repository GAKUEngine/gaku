require 'spec_helper'

describe 'ClassGroup Courses' do
  stub_authorization!
  
  before do
    @class_group = Factory(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
    @course = Factory(:course, :code => 'Math2012')
    visit class_group_path(@class_group)
    click_link 'class_group_courses_tab_link'
  end

  it 'should add and show course to a class group', :js => true do
    ClassGroupCourseEnrollment.count.should == 0
    tr_count = page.all('#courses_index tbody tr').size
    click_link 'add_class_group_course_link'
    wait_until { page.find('#add_class_group_course').visible? }
    select "#{@course.code}", :from => 'class_group_course_enrollment_course_id'
    click_button 'submit_course_button'

    wait_until { page.all('#courses_index tbody tr').size == tr_count + 1 }
    within("#courses_index tbody"){
      page.should have_content ("#{@course.code}")
    }
    ClassGroupCourseEnrollment.count.should == 1

  end

  it 'should not add a course if course code is empty', :js => true do
    click_link 'add_class_group_course_link'
    wait_until { page.find('#add_class_group_course').visible? }
    click_button 'submit_course_button'

    wait_until { page.has_content?('Course can\'t be blank') }
  end

  context 'Class group with added course' do
    before do
      @class_group.courses<<@course
      visit class_group_path(@class_group)
      click_link 'class_group_courses_tab_link'
      
    end

    it 'should not add a course if it is already added', :js => true do  
      
      click_link 'add_class_group_course_link'
      wait_until { page.find('#add_class_group_course').visible? }
      select "#{@course.code}", :from => 'class_group_course_enrollment_course_id'
      click_button 'submit_course_button'

      wait_until { page.should have_content("Course Already enrolled to the class group!") }
      
    end

    it 'should delete a course from class group', :js => true do  
      ClassGroupCourseEnrollment.count.should == 1
      @class_group.courses.count.should == 1
      page.all('#courses_index tbody tr').size.should == 1
      within("#courses_index tbody"){
        page.should have_content ("#{@course.code}")
        click_on "delete_link"
      }
      page.driver.browser.switch_to.alert.accept
      
      within("#courses_index tbody"){ page.should_not have_content("#{@course.code}") }
      ClassGroupCourseEnrollment.count.should == 0
      @class_group.courses.count.should == 0
    end
  end

end
