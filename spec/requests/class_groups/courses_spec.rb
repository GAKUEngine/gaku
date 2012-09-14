require 'spec_helper'

describe 'ClassGroup Courses' do
  stub_authorization!
  
  before do
    @class_group = Factory(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
    @course = Factory(:course)
    visit class_group_path(@class_group)
    click_link 'class_group_courses_tab_link'
  end

  it 'should add and show course to a class group', :js => true do
    ClassGroupCourseEnrollment.count.should == 0
    tr_count = page.all('#courses_index tr').size
    click_link 'add_class_group_course_link'
    wait_until { page.find('#add_class_group_course').visible? }
    select "#{@course.code}", :from => 'class_group_course_enrollment_course_id'
    click_button 'submit_course_button'

    wait_until { page.all('#courses_index tr').size == tr_count+1 }
    within("#courses_index tbody"){
      page.should have_content ("#{@course.code}")
    }
    ClassGroupCourseEnrollment.count.should == 1

  end

  pending 'should not add a course if course code is empty', :js => true do #FIXME cannot load the validation code properly
    click_link 'show_course_form'
    wait_until { page.find('#add_class_group_course').visible? }
    click_button 'submit_course_button'

    wait_until { page.has_content?('This field is required') }
  end

  context 'Class group with added course' do
    before do
      @class_group.courses<<@course
      visit class_group_path(@class_group)
      click_link 'class_group_courses_tab_link'
      
    end

    pending 'should not add a course if it is already added' do  
      #TODO need to be implemented in the main logic
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
      wait_until { page.all('#courses_index tbody tr').size.should == 0 }
      ClassGroupCourseEnrollment.count.should == 0
      @class_group.courses.count.should == 0
    end
  end

end
