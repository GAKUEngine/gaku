require 'spec_helper'

describe 'Student' do
  stub_authorization!

  context "existing students" do
    before do 
      @student = Factory(:student, :name => 'John', :surname => 'Doe')
      @student2 = Factory(:student, :name => 'Susumu', :surname => 'Yokota')
      @student3 = Factory(:student, :name => 'Johny', :surname => 'Bravo')
      visit students_path
    end

    it "should list existing students" do
      page.all('#students-index tr').size.should eql(4)
      page.should have_content("#{@student.name}")
      page.should have_content("#{@student.surname}")
      page.should have_content("#{@student2.name}")
      page.should have_content("#{@student2.surname}")
      page.should have_content("#{@student3.name}")
      page.should have_content("#{@student3.surname}")
    end

    it "should have autocomplete while searching", :js => true do
      page.all('#students-index tr').size.should eql(4)

      fill_in 'q_name_cont', :with => "J"
      wait_until do  
        within ('#students-index') do
          page.should have_content("John") 
          page.should have_content("Johny")
        end
        sleep(1)
        page.all('#students-index tr').size.should eql(3)
      end
      

      fill_in 'q_surname_cont', :with => "B"
      wait_until do 
        within ('#students-index') do
          page.should have_content("Johny")
          page.should have_content("Bravo")
        end
        page.all('#students-index tr').size.should eql(2)
      end 
    end

    it "should edit an existing student", :js => true do
      visit student_path(@student)
      page.should have_content("#{@student.name}")
      click_link 'edit-student-link'
      page.should have_content("Edit")
      fill_in "student_surname", :with => "Kostova"
      fill_in "student_name", :with => "Marta"
      click_button 'submit-student-button'

      page.should have_content("Kostova Marta")
      @student.name.should eql("Marta") 
    end
    
    it 'should delete an existing student', :js => true do
      visit student_path(@student)
      student_count = Student.all.count
      page.should have_content("#{@student.name}")
      click_link 'delete-student-link'
      
      within(".delete_modal") { click_on "Delete" }
      page.driver.browser.switch_to.alert.accept
      
      page.should_not have_content("#{@student.name}")
      Student.all.count.should == student_count - 1
    end

    it 'should enroll to class', :js => true do 
      ClassGroupEnrollment.count.should eql(0)
      Factory(:class_group, :name => 'Biology')
      visit student_path(@student)
      click_link 'enroll-student-link'
      wait_until { find('#new-class-group-enrollment-modal').visible? }

      select 'Biology', :from => 'class_group_enrollment_class_group_id'
      fill_in 'class_group_enrollment_seat_number', :with => '77'
      click_button "Create Class Enrollment"
      click_link 'Cancel'

      wait_until { !page.find('#new-class-group-enrollment-modal').visible? }
      click_link 'enroll-student-link'
      within('#new-class-group-enrollment-modal') do
        page.should have_content('Biology')
        page.should have_content('77')
      end
      ClassGroupEnrollment.count.should eql(1)

      visit student_path(@student)
      within('.table td#student-class-group-enrollment') do 
        page.should have_content('Biology')
        page.should have_content('77')
      end
    end

  end

  context "new student", :js => true do 
    it "should create new student" do 
      visit students_path
      click_link "new-student-link"
      fill_in "student_name", :with => "John"
      fill_in "student_surname", :with => "Doe"
      click_button "submit-student-button"
      page.should have_content("John")
      Student.all.count.should eql(1)
    end
  end

end