require 'spec_helper'

describe 'CourseGroups' do
  stub_authorization!

  before do
    visit course_groups_path
  end

  it 'should create and show a course group', :js => true do
    CourseGroup.count.should eql(0)
    click_link 'new-course-group-link'

    wait_until { find("#new-course-group-form").visible? }
    fill_in 'course_group_name', :with => 'MathCourses2012'
    click_on 'submit-course-group-button'

    page.should have_content 'Course Group Created'
    within ('#course-groups-index') { page.should have_content 'MathCourses2012' }
    CourseGroup.count.should  eql(1)
  end

  it 'should not add new if name is empty', :js => true do
    click_link 'new-course-group-link'

    wait_until { find("#new-course-group-form").visible? }
    click_button 'submit-course-group-button'

    page.should have_content('can\'t be blank')
  end

  it 'should not add new if back is clicked', :js => true do
    CourseGroup.count.should eql(0)
    click_on 'new-course-group-link'

    wait_until { find('#new-course-group-link').visible? }
    click_on 'Back'

    wait_until { !find('#new-course-group-form').visible? }
  end

  context 'when course group is created' do
    before do 
      @course_group = Factory(:course_group, :name => '2013Courses')
      visit course_groups_path
    end

    it 'should edit course group from index view', :js => true do 
      within('#course-groups-index tbody') { find('.edit-link').click }
      wait_until { find('#edit-course-group-modal').visible? }

      fill_in 'course_group_name', :with => '2012 Courses'
      
      click_button 'submit-course-group-button'

      within ('#course-groups-index') do
        page.should have_content '2012 Courses'
        page.should_not have_content '2013Courses'
      end

      CourseGroup.last.name.should eql('2012 Courses')
    end

    it 'should not edit a class group if back button is clicked while editing', :js => true do
      
      within('#course-groups-index tbody') { find('#edit-course-group-link').click }
      wait_until { find('#edit-course-group-modal').visible? }

      find('.close').click
      
      within ('#course-groups-index') { page.should have_content '2013Courses' }
      CourseGroup.last.name.should eql('2013Courses')
    end

    it 'should edit course group from show view', :js => true do #TODO to be implemented
      CourseGroup.count.should eql(1)
      visit course_group_path(@course_group)
      find(".edit-link").click

      wait_until { find('#edit-course-group-modal').visible? }
      fill_in 'course_group_name', :with => '2012 Courses'
      click_button 'submit-course-group-button'

      within ('.table') do 
        page.should have_content '2012 Courses'
        page.should_not have_content '2013Courses'
      end

      CourseGroup.last.name.should eql('2012 Courses')
    end

    it 'should delete the course group', :js => true do 
      CourseGroup.count.should eql(1)
      visit course_group_path(@course_group)
      wait_until { page.should have_content('Add Course') } 
      click_on "delete-course-group-link"
      within(".delete-modal") { click_on "Delete" }
      page.driver.browser.switch_to.alert.accept
      
      wait_until { page.should have_content 'was successfully destroyed.' }
      within('#course-groups-index tbody') { page.should_not have_content(@course_group.name) }
      CourseGroup.all.count.should eql(0)
    end

    it 'should return to class_groups index when back selected' do 
      visit course_group_path(@course_group)
      click_on('Back')
      page.should have_content ('Course Groups List')
    end

    it 'should redirect to show view when show btn selected' do
      within('#course-groups-index tbody') { find('#show-course-group-link').click }
      page.should have_content ('Course Group')
      page.should have_content ('Courses List')
    end
    
  end
end