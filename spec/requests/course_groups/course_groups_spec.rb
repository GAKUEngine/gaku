require 'spec_helper'

describe 'CourseGroups' do
  
  table_rows = '#course-groups-index tbody tr'
  count_div = '.course-groups-count'

  stub_authorization!

  before do
    visit course_groups_path
  end

  context 'new' do 
    it 'should create and show a course group', :js => true do
      tr_count = page.all(table_rows).size

      expect do
        click '#new-course-group-link'

        wait_until_visible "#new-course-group form"
        fill_in 'course_group_name', :with => 'MathCourses2012'
        click '#submit-course-group-button'
      end.to change(CourseGroup, :count).by(1)

      flash_created?
      within(count_div) { page.should have_content('Course Groups List(1)') }
      within ('#course-groups-index') { page.should have_content 'MathCourses2012' }
      wait_until { page.all(table_rows).size == tr_count + 1 }

    end

    it 'should not add new if name is empty', :js => true do
      click_link 'new-course-group-link'

      wait_until { find('#submit-course-group-button').visible? }
      click_button 'submit-course-group-button'

      page.should have_content('can\'t be blank')
    end

    it 'should cancel adding', :js => true do
      click_link 'new-course-group-link'

      wait_until { find('#cancel-course-group-link').visible? }
      click_link 'cancel-course-group-link'

      wait_until { !find('#new-course-group form').visible? }
      click_link 'new-course-group-link'

      wait_until { find('#new-course-group form').visible? }
    end
  end

  context 'existing course group' do
    before do 
      @course_group = create(:course_group, :name => '2013Courses')
      visit course_groups_path
    end

    it 'should edit course group from index view', :js => true do 
      
      within('#course-groups-index tbody') { find('.edit-link').click }

      wait_until_visible '#edit-course-group-modal'
      fill_in 'course_group_name', :with => '2012 Courses'
      click '#submit-course-group-button'

      within ('#course-groups-index tbody') do
        page.should have_content '2012 Courses'
        page.should_not have_content '2013Courses'
      end

      CourseGroup.last.name.should eql('2012 Courses')
      flash_updated?
    end

    it 'cancel editting', :js => true do
      within('#course-groups-index tbody') { find('.edit-link').click }
      wait_until { find('#edit-course-group-modal').visible? }

      click_link 'cancel-course-group-link'
      wait_until { !page.find('#edit-course-group-modal').visible? }
    end

    it 'should edit course group from show view', :js => true do #TODO to be implemented
      CourseGroup.count.should eq 1
      visit course_group_path(@course_group)
      find(".edit-link").click

      wait_until { find('#edit-course-group-modal').visible? }
      fill_in 'course_group_name', :with => '2012 Courses'
      click_button 'submit-course-group-button'

      within ('.table') do 
        page.should have_content '2012 Courses'
        page.should_not have_content '2013Courses'
      end
      CourseGroup.count.should eq 1
      CourseGroup.last.name.should eq '2012 Courses'
    end

    it 'should delete the course group', :js => true do 
      CourseGroup.count.should eq 1
      visit course_group_path(@course_group)
      wait_until { page.should have_content('Add Course') } 
      click_on "delete-course-group-link"
      within(".delete-modal") { click_on "Delete" }
      page.driver.browser.switch_to.alert.accept
      
      flash_destroyed?
      within('#course-groups-index tbody') { page.should_not have_content(@course_group.name) }
      CourseGroup.all.count.should eq 0
    end

    it 'should return to class_groups index when back selected' do 
      visit course_group_path(@course_group)
      click_on('Back')
      page.should have_content ('Course Groups List')
    end

    it 'should redirect to show view when show btn selected' do
      within('#course-groups-index tbody') { find('.show-link').click }
      page.should have_content ('Course Group')
      page.should have_content ('Courses list')
    end
    
  end
end