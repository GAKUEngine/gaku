require 'spec_helper'

describe 'ClassGroup ClassGroupEnrollment' do
  before do
    sign_in_as!(Factory(:user))
    @class_group = Factory(:class_group, :grade => '1', :name => "Biology", :homeroom => 'A1')
    @student1 = Factory(:student)
    within('ul#menu') { click_link "Class Management" }
    within('ul#menu') { click_link "Class Listing" }
  end

  context "Class Roster" do
    before do
      click_link 'show_link'
      click_link 'class_group_enrollments_tab_link'
    end

    it 'should add and show student to a class group', :js => true do
      
      click_link 'add_class_group_enrollment'
      wait_until { page.find('#new_class_enrollment').visible? }
      check "#{@student1.id}"
      click_button 'submit_button'
      wait_until { !page.find('#new_class_enrollment').visible? }

      page.should have_content("#{@student1.name}")
    end

    context "Class Roster with added student" do
      before do
        @class_group.students << @student1
        visit class_group_path(@class_group)
      end

      it 'should not show a student for adding if it is already added', :js => true do
        click_link 'add_class_group_enrollment'
        wait_until { page.find('#new_class_enrollment').visible? }
        within('#new_class_enrollment') { page.should_not have_content("#{@student1.name}") }
      end


      it 'should delete a student from a class group', :js => true do
        click_link 'class_group_enrollments_tab_link'
        
        tr_count = page.all('table.index tr').size
        click_link('delete_link') 
        page.driver.browser.switch_to.alert.accept
   
        wait_until { page.all('table.index tr').size == tr_count - 1 }
        @class_group.students.count.should == 0
      end
    end

  end

  context 'Semesters' do
    before do
      click_link 'show_link'
      click_link 'class_group_semesters_tab_link'
    end
    it 'should add and show semester to a class group', :js => true do
      
      click_link 'show_semester_form'
      wait_until { page.find('#semester_form').visible? }
      #select a semester
      select '2012', :from => 'semester_starting_1i'
      select 'September', :from => 'semester_starting_2i'
      select '28', :from => 'semester_starting_3i'

      select '2012', :from => 'semester_ending_1i'
      select 'December', :from => 'semester_ending_2i'
      select '20', :from => 'semester_ending_3i'
      click_button 'submit_button'
      wait_until { !page.find('#semester_form').visible? }

      page.should have_content('09/28/2012 - 12/20/2012')
    
    end

    context 'Class group with added semester' do
      pending 'should not add a semester if it is already added' do #need to be implemeted in the main logic
      end
      pending 'should delete a semester from class group' do #need to be implemented in the main logic
      end
    end

  end
  
  context 'Courses' do
      before do
        click_link 'show_link'
        click_link 'class_group_courses_tab_link'
      end

      it 'should add and show course to a class group', :js => true do
        click_link 'show_course_form'
        wait_until { page.find('#course_form').visible? }
        fill_in 'course_code', :with => 'Biology321'
        click_button 'submit_button'

        page.should have_content ('Biology321') #TODO test the redirect from class group to a course
        visit class_group_path(@class_group)
        click_link 'class_group_courses_tab_link'
        within('.tab-content') { page.should have_content 'Biology321'}
      end

      pending 'should not add a course if course code is empty', :js => true do #FIXME cannot load the validation code properly
        click_link 'show_course_form'
        wait_until { page.find('#course_form').visible? }
        click_button 'submit_button'

        wait_until { page.has_content?('This field is required') }
      end

      context 'Class group with added course' do
        pending 'should not add a course if it is already added' do  #need to be implemented in the main logic
        end
        pending 'should delete a course from class group' do  #need to be implemented in the main logic
        end
      end

  end

end
