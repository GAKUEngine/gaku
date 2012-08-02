require 'spec_helper'

describe 'Student' do
  before do
    @student = Factory(:student)
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
      visit student_path(@student)
      page.should have_link "Enroll to class"
    end
  
    it "should list enrolled courses" do
      visit student_path(@student)
      page.should have_content "Courses List"
    end

    it "should exist enroll_to_course link" do
      visit student_path(@student)
      page.should have_link "Enroll to course"
    end

    it "should exist edit link on student nested note" do
      @student.notes << Factory(:note)
      visit student_path(@student)
      @student.notes.size.should == 1
      page.should have_selector('a', href: "/students/1/notes/1/edit")
    end
  end

  context "studets contacts"  do
    before(:each) do
      @contact = Factory(:contact, :student_id => @student)    
    end 
    it "should have contact" do
      visit student_path(@student)
      page.should have_content("#{@contact.data}") 
    end

    it "should have right contact classes in tr" do
      visit student_path(@student)
      page.should have_css("tr.student_contact.contact_#{@contact.id}") 
    end

    it "should have primary column with right class " do
      visit student_path(@student)
      page.should have_css('td.primary_contact') 
    end

    it "should have action column with right class for button " do
      visit student_path(@student)
      page.should have_css('td.primary_button') 
    end

    it "should have form with new_student_contact_form class " do
      visit student_path(@student)
      page.should have_css('form.new_student_contact_form') 
    end

  end

end
