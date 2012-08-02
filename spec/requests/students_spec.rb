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

    it "should allow to add a student address", :js => true do
      Factory(:country, :name => "Japan")
      visit student_path(@student)

      click_link 'new_address_link'
      click_link 'new_student_address_link'

      wait_until { page.has_content?('Country') } 
      #required
      select "Japan", :from => 'country_dropdown'
      fill_in "student_addresses_attributes_0_city", :with => "Nagoya"
      fill_in "student_addresses_attributes_0_address1", :with => "Subaru str."

      fill_in "student_addresses_attributes_0_title", :with => "John Doe main address"
      fill_in "student_addresses_attributes_0_zipcode", :with => "00359"
      fill_in "student_addresses_attributes_0_address2", :with => "Toyota str."
      #fill_in "student_addresses_attributes_0_state", :with => "Aichi"
     

      click_button "Save address"

      @student.addresses.size.should == 1
      page.should have_selector('a', href: "/students/1/addresses/1/edit")

      #required
      page.should have_content("Japan")
      page.should have_content("Nagoya")
      page.should have_content("Subaru str.")
      
      page.should have_content("John Doe main address")
      page.should have_content("00359")
      page.should have_content("Toyota str.")
      #page.should have_content("Aichi")
      
    end
    
    it "should exist edit link on student nested guardian" do
      @student.guardians << Factory(:guardian)
      visit student_path(@student)
      @student.guardians.size.should == 1
      page.should have_selector('a', href: "/students/1/guardians/1/edit")
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
