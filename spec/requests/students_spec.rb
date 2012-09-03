require 'spec_helper'

describe 'Student' do
  stub_authorization!

  before do
    @student = Factory(:student)
    visit students_path
    #within('ul#menu') { click_link "Students" }
  end

  context "listing" do
    it "should list existing students", :js => true do
      page.should have_selector('div#students_grid_table')
      page.should have_content("#{@student.name}")
    end
    it "should have autocomplete while searching", :js => true do
      within ('#students_grid_table'){ page.should have_content("#{@student.name}") }
      fill_in 'student_search', :with => "#{@student.name}"
      page.all('#students_grid_table tr').size.should==2
      within ('#students_grid_table'){ page.should have_content("#{@student.name}") }
    end
  end

  context "creating", :js => true do 
    it "should create new student" do 
      click_link "new_student_link"
      fill_in "student_name", :with => "John"
      fill_in "student_surname", :with => "Doe"
      click_button "Create Student"
      page.should have_selector('div#students_grid_table')
      page.should have_content("John")
    end
  end

  context "showing" do
    it "should exist enroll_to_class link" do
      visit student_path(@student)
      page.should have_link "Enroll to class"
    end
  
    it "should list enrolled courses" do
      visit student_path(@student)
      click_link 'new_student_course_tab_link'
      wait_until { page.has_content?('Courses List') }
    end

    it "should exist enroll_to_course link" do
      visit student_path(@student)
      click_link 'new_student_course_tab_link'
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
    it 'should delete an existing student' do
      visit student_path(@student)
      st_count = Student.all.count
      page.should have_content("#{@student.name}")
      find_link("Delete").click
      
      within (".delete_modal") {
        click_on "Delete"
        page.driver.browser.switch_to.alert.accept
      }
      wait_until { page.should have_content 'Student was successfully destroyed.' }
      page.should_not have_content("#{@student.name}")
      Student.all.count.should == st_count - 1
    end
  end

end
