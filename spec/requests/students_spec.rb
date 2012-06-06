require 'spec_helper'

describe 'Student' do
  before do
    @student1 = Factory(:student)
    sign_in_as!(Factory(:user))
  end

  context "listing students" do
    it "should list existing students" do
      visit students_path
      #save_and_open_page
      #page.should have_content @student1.name
    end
  end

  context "creating new student" do 
    it "should create new student" do 
      visit students_path
      click_link "new_student_link"
      #TODO fix default locale to English
      #page.should have_content "Register New Student"
      fill_in "student_name", :with => "John"
      fill_in "student_email", :with => "john@example.com"
      click_button "Create"
    end
  end
end