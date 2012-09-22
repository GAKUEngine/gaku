require 'spec_helper'

describe 'Student' do
  stub_authorization!

  before do
    @student = Factory(:student)
    visit students_path
  end

  context "listing" do
    it "should list existing students", :js => true do
      page.should have_content("#{@student.name}")
    end

    it "should have autocomplete while searching", :js => true do
      within ('#student_index'){ page.should have_content("#{@student.name}") }
      fill_in 'q_name_cont', :with => "#{@student.name}"
      page.all('#student_index tr').size.should eql(2)
      within ('#student_index'){ page.should have_content("#{@student.name}") }
    end
  end

  context "creating", :js => true do 
    it "should create new student" do 
      click_link "new_student_link"
      fill_in "student_name", :with => "John"
      fill_in "student_surname", :with => "Doe"
      click_button "Create Student"
      page.should have_content("John")
    end
  end

  context "showing" do
    it "should exist enroll_to_class link" do
      visit student_path(@student)
      page.should have_link "Enroll to class"
    end
    
    it "should exist enroll_to_course link" do
      visit student_path(@student)
      click_link 'new-student-course-enrollment-tab-link'
      wait_until { page.has_content?('Courses List') }
      page.should have_link "Enroll to course"
    end

  end

  context "editing", :js => true do
    it "should edit an existing student" do
      visit student_path(@student)
      page.should have_content("#{@student.name}")
      find_link("Edit").click
      page.should have_content("Edit")
      fill_in "student_surname", :with => "Kostova"
      fill_in "student_name", :with => "Marta"
      click_on "Update Student"
      click_on "Show Students"
      page.should have_content("Kostova Marta")
      Student.last.name.should == "Marta" 
    end
  end

  context "deleting", :js => true do
    pending 'should delete an existing student' do
      visit student_path(@student)
      student_count = Student.all.count
      page.should have_content("#{@student.name}")
      click_link 'delete_link'
      
      within (".delete_modal") { click_on "Delete" }
      page.driver.browser.switch_to.alert.accept
      
      wait_until { page.should have_content 'was successfully destroyed.' }
      page.should_not have_content("#{@student.name}")
      Student.all.count.should == student_count - 1
    end
  end

end
