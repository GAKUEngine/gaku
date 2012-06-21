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
      fill_in "name", :with => "John"
      fill_in "surname", :with => "Doe"
      click_button "Submit"
    end
  end
end