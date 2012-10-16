require 'spec_helper'

describe 'Student' do
  stub_authorization!

  context "existing students" do
    before do 
      @student = create(:student, :name => 'John', :surname => 'Doe')
      @student2 = create(:student, :name => 'Susumu', :surname => 'Yokota')
      @student3 = create(:student, :name => 'Johny', :surname => 'Bravo')
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

    it 'should choose students', :js => true do 
      find(:css, "input#student-#{@student.id}").set(true)
      wait_until { find('#students-checked-div').visible? }
      within('#students-checked-div') do 
        page.should have_content('Chosen students(1)')
        click_link('Show')
        wait_until { find('#chosen-table').visible? }
        page.should have_content("#{@student.name}")
        page.should have_button('Enroll to class')
        page.should have_button('Enroll to course')
        click_link('Hide')
        wait_until { !page.find('#chosen-table').visible? }
      end
    end

    it "should have autocomplete while searching", :js => true do
      page.all('#students-index tr').size.should eql(4)

      fill_in 'q_name_cont', :with => "J"
      wait_until do  
        within ('#students-index') do
          page.should have_content("John") 
          page.should have_content("Johny")
        end
        sleep 2 #FIXME
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

    it "should edit an existing student from show", :js => true do
      visit student_path(@student)
      page.should have_content("#{@student.name}")
      find('.edit-link').click
      wait_until { find('#edit-student-modal').visible? }
      fill_in "student_surname", :with => "Kostova"
      fill_in "student_name", :with => "Marta"
      click_button 'submit-student-button'
      wait_until { !page.find('#edit-student-modal').visible? }

      page.should have_content("Kostova")
      page.should have_content("Marta")
      @student.reload
      @student.name.should eql("Marta") 
      @student.surname.should eql("Kostova") 
    end

    it "should edit an existing student from index", :js => true do
      visit students_path
      page.should have_content("#{@student.name}")
      find('.edit-link').click
      
      wait_until { find('#edit-student-modal').visible? }
      fill_in "student_surname", :with => "Kostova"
      fill_in "student_name", :with => "Marta"
      click_button 'submit-student-button'
      wait_until { !page.find('#edit-student-modal').visible? }

      page.should have_content("Kostova")
      page.should have_content("Marta")
      @student.reload
      @student.name.should eql("Marta") 
      @student.surname.should eql("Kostova") 
    end

    it 'should cancel editting', :js => true do
      visit students_path
      find('.edit-link').click

      wait_until { find('#edit-student-modal').visible? }
      click_link 'back-student-link'
      current_path.should == students_path
    end
    
    it 'should delete an existing student', :js => true do
      visit student_path(@student2)
      student_count = Student.count
      page.should have_content("#{@student2.name}")
      find('#delete-student-link').click
      
      within(".delete_modal") { click_on "Delete" }
      page.driver.browser.switch_to.alert.accept
      
      wait_until { page.should have_content('successfully destroyed') }
      page.should_not have_content("#{@student2.name}")
      within('.students-count') { page.should_not have_content('Students list(#{student_count - 1})') }
      current_path.should eq students_path
      Student.count.should eq(student_count - 1)
    end

    it 'should enroll to class', :js => true do 
      ClassGroupEnrollment.count.should eql(0)
      create(:class_group, :name => 'Biology')
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

  context "new", :js => true do 
    before do 
      visit students_path
      click_link "new-student-link"
      wait_until { page.find('#new-student').visible? }
    end

    it "should create new student" do 
      Student.count.should eq 0
      within('.students-count') { page.should have_content('Students list') }

      fill_in "student_name", :with => "John"
      fill_in "student_surname", :with => "Doe"
      click_button "submit-student-button"

      wait_until { !page.find('#new-student').visible? }
      page.should have_content("John")
      within('.students-count') { page.should have_content('Students list(1)') }
      Student.count.should eq 1
    end

    it 'should cancel creating' do 
      click_link 'cancel-student-link'
      wait_until { !page.find('#new-student').visible? }

      click_link "new-student-link"
      wait_until { page.find('#new-student').visible? }
    end
  end

end