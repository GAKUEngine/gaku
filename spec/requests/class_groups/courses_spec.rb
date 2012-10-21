require 'spec_helper'

describe 'ClassGroup Courses' do
  
  form          = '#new-class-group-course'
  new_link      = '#new-class-group-course-link'
  
  cancel_link   = '#cancel-class-group-course-link'
  submit_button = '#submit-course-button'
  
  table_rows    = 'table#courses-index tbody tr'
  count_div     = '.courses-count'
  tab_link      = '#class-group-courses-tab-link'

  stub_authorization!
  
  before do
    @class_group = create(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
    @course = create(:course, :code => 'Math2012')
    visit class_group_path(@class_group)
    click tab_link
  end

  it 'add and show course to a class group', :js => true do
    
    click new_link
    wait_until_visible form
    expect do
      select "#{@course.code}", :from => 'class_group_course_enrollment_course_id'
      click submit_button
      wait_until_invisible form
    end.to change(ClassGroupCourseEnrollment, :count).by 1
  
    size_of(table_rows).should eq 1
    within("#courses-index tbody"){ page.should have_content ("#{@course.code}") }
    within(count_div){ page.should have_content("1") }
    within(tab_link){ page.should have_content("1") }

  end

  it 'not add a course if course code is empty', :js => true do
    click new_link
    wait_until_visible form
    click submit_button

    wait_until { page.has_content?('Course can\'t be blank') }
  end

  pending 'cancel adding', :js => true do
    click new_link
    wait_until_visible form

    click cancel_link
    wait_until_invisible form

    click new_link
    wait_until_visible form
  end

  context 'existing', :js => true do
    before do
      @class_group.courses << @course
      visit class_group_path(@class_group)
      click tab_link

      within(count_div) { page.should have_content("1") }
      within(tab_link) { page.should have_content("1") }
      size_of(table_rows).should eq 1
    end

    it 'not add a course 2 times' do  
      click new_link
      wait_until_visible form
      select "#{@course.code}", :from => 'class_group_course_enrollment_course_id'
      click submit_button
      wait_until { page.should have_content("Course Already enrolled to the class group!") }   
    end

    it 'delete a course from a class group' do  
      expect do
        ensure_delete_is_working(delete_link, table_rows)
      end.to change(ClassGroupCourseEnrollment, :count).by -1
  
      within("#courses-index tbody"){ page.should_not have_content("#{@course.code}") }
      within(count_div){ page.should_not have_content("1") }
      within(tab_link){ page.should_not have_content("1") }
    end
  end

end
