require 'spec_helper'

describe 'CourseGroups' do
  stub_authorization!

  before do
    visit course_groups_path
  end

  it 'should create and show a course group', :js => true do
    CourseGroup.count.should == 0
    click_on 'New Course Group'

    wait_until { find("#add_new_course_group_form").visible? }
    fill_in 'course_group_name', :with => 'MathCourses2012'
    click_on 'Create Course group'

    page.should have_content 'Course Group Created'
    within ('#course_groups_index_table') { page.should have_content 'MathCourses2012' }
    CourseGroup.count.should == 1
  end

  context 'show, edit, delete' do
    before do 
      @course_group = Factory(:course_group, :name => '2013Courses')
      visit course_groups_path
    end

    it 'should edit course group from index view', :js => true do 
      
      within('#course_groups_index_table tbody') { find('#edit_course_group_link').click }
      wait_until { find('#edit_course_group_modal').visible? }

      fill_in 'course_group_name', :with => '2012 Courses'
      
      click_button 'Update Course group'

      within ('#course_groups_index_table') { 
        page.should have_content '2012 Courses'
        page.should_not have_content '2013Courses'
      }

      CourseGroup.last.name.should == '2012 Courses'
      
    end

    it 'should not edit a class group if back button is clicked while editing', :js => true do
      
      within('#course_groups_index_table tbody') { find('#edit_course_group_link').click }
      wait_until { find('#edit_course_group_modal').visible? }

      find('.close').click
      
      within ('#course_groups_index_table') { page.should have_content '2013Courses' }
      CourseGroup.last.name.should == '2013Courses'
    end

    it 'should edit course group from show view', :js => true do #TODO to be implemented
      CourseGroup.count.should == 1
      visit course_group_path(@course_group)
      click_link("Edit")
      wait_until { find('#edit_course_group_modal').visible? }

      fill_in 'course_group_name', :with => '2012 Courses'
      
      click_button 'Update Course group'

      within ('.table') { 
        page.should have_content '2012 Courses'
        page.should_not have_content '2013Courses'
      }

      CourseGroup.last.name.should == '2012 Courses'
    end

    it 'should delete the course group', :js => true do 
      CourseGroup.count.should == 1
      visit course_group_path(@course_group)
      wait_until { page.should have_content('Add Course') } 
      click_on "delete_link"
      within (".delete_modal") { click_on "Delete" }
      page.driver.browser.switch_to.alert.accept
      
      wait_until { page.should have_content 'was successfully destroyed.' }
      within('#course_groups_index_table tbody') { page.should_not have_content(@course_group.name) }
      CourseGroup.all.count.should == 0
      
    end

    it 'should return to class_groups index when back selected' do 
      visit course_group_path(@course_group)
      click_on('Back')
      page.should have_content ('Course Groups List')
    end

    it 'should redirect to show view when show btn selected' do
      within('#course_groups_index_table tbody') { find('#show_course_group_link').click }
      page.should have_content ('Course Group')
      page.should have_content ('Courses List')
    end
  end
end