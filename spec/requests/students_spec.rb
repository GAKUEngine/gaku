require 'spec_helper'

describe 'Student' do
  before do
    @student1 = Factory(:student)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Students List"}
  end

  context "listing students" do
    it "should list existing students" do

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
end