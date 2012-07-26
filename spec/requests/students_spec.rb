require 'spec_helper'

describe 'Student' do
  before do
    @student1 = Factory(:student)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Students"}
  end

  context "listing students" do
    it "should list existing students" do
      page.should have_content "Students List "
    end
  end

  context "creating new student" do 
    it "should create new student" do 
      click_link "new_student_link"
      fill_in "student_name", :with => "John"
      fill_in "student_surname", :with => "Doe"
      click_button "Create Student"
    end
  end

  context "show student" do
    it "should exist enroll_to_class link" do
      visit student_path(@student1)
      page.should have_link "Enroll to class"
    end
  
    it "should list enrolled courses" do
      visit student_path(@student1)
      page.should have_content "Courses List"
    end

    it "should exist enroll_to_course link" do
      visit student_path(@student1)
      page.should have_link "Enroll to course"
    end

    it "should exist edit link on student nested address" do
      @student1.addresses << Factory(:address)
      visit student_path(@student1)
      @student1.addresses.size.should == 1
      page.should have_selector('a', href: "/students/1/addresses/1/edit")
    end
    
    it "should exist edit link on student nested guardian" do
      @student1.guardians << Factory(:guardian)
      visit student_path(@student1)
      @student1.guardians.size.should == 1
      page.should have_selector('a', href: "/students/1/guardians/1/edit")
    end

    it "should exist edit link on student nested note" do
      @student1.notes << Factory(:note)
      visit student_path(@student1)
      @student1.notes.size.should == 1
      page.should have_selector('a', href: "/students/1/notes/1/edit")
    end
  end

end
