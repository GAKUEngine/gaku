require 'spec_helper'

describe 'ClassGroup Students' do
  stub_authorization!

  before do
    @class_group = Factory(:class_group, :grade => '1', :name => "Biology", :homeroom => 'A1')
    @student1 = Factory(:student, :name => 'Susumu', :surname => 'Yokota')
  end

  context "Class Roster" do
    before do
      visit class_groups_path
      find('.show-link').click
      click_link 'class-group-enrollments-tab-link'
      ClassGroupEnrollment.count.should == 0
    end

    it 'should add and show student to a class group', :js => true do
      click_link 'new-class-group-student-link'
      wait_until { page.find('#student-modal').visible? }
      check "#{@student1.id}"
      click_button 'submit-student-button'
      wait_until { !page.find('#student-modal').visible? }

      within('#students-index'){ page.should have_content("#{@student1.name}") }
      within('.enrollments-count'){ page.should have_content("1") }
      within('#class-group-enrollments-tab-link'){ page.should have_content("1") }
      ClassGroupEnrollment.count.should == 1
    end

    it 'should not add a student if cancel is selected', :js => true do
      click_link 'new-class-group-student-link'
      wait_until { page.find('#student-modal').visible? }
      check "#{@student1.id}"
      click_on 'cancel-student-link'
      wait_until { !page.find('#student-modal').visible? }

      within('#students-index'){ page.should_not have_content("#{@student1.name}") }
      within('.enrollments-count'){ page.should_not have_content("1") }
      within('#class-group-enrollments-tab-link'){ page.should_not have_content("1") }
      ClassGroupEnrollment.count.should == 0
    end

    pending 'should search students', :js => true do
      student2 = Factory(:student, :name => 'Kenji', :surname => 'Kita')
      student3 = Factory(:student, :name => 'Chikuhei', :surname => 'Nakajima')

      click_link 'new-class-group-student-link'
      wait_until { page.find('#student-modal').visible? }

      table_rows = page.all('div#students-index table tr').size
      fill_in 'student_search', :with => 'Sus'
     
      wait_until { page.all('div#students-index table tr').size == table_rows - 2 } 
    end

    context "Class Roster with added student" do
      before do
        @class_group.students << @student1
        visit class_group_path(@class_group)
        within('.enrollments-count'){ page.should have_content("1") }
        within('#class-group-enrollments-tab-link'){ page.should have_content("1") }
        ClassGroupEnrollment.count.should == 1
      end

      it 'should not show a student for adding if it is already added', :js => true do
        click_link 'new-class-group-student-link'
        wait_until { page.find('#student-modal').visible? }
        within('#student-modal') { page.should_not have_content("#{@student1.name}") }
      end

      it 'should delete a student from a class group', :js => true do
        click_link 'class-group-enrollments-tab-link'
        @class_group.students.count.should eql(1)
        tr_count = page.all('table#students-index tr').size

        find('.delete-link').click 
        page.driver.browser.switch_to.alert.accept
        
        wait_until { page.all('table#students-index tr').size == tr_count - 1 }
        @class_group.students.count.should eql(0)
        within('.enrollments-count') { page.should_not have_content("1") }
        within('#class-group-enrollments-tab-link') { page.should_not have_content("1") }
        ClassGroupEnrollment.count.should == 0
      end
    end
  end

end