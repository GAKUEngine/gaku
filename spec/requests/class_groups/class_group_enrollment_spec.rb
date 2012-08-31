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

end
