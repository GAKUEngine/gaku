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
      click_button "Submit"
    end
  end

  context "show student" do
    it "should exist enroll_to_class link" do
      visit student_path(@student1)
      page.should have_link "Enroll to class"
    end
end
end
