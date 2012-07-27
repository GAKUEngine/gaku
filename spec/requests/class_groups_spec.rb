require 'spec_helper'

describe 'ClassGroups' do
  before do
    @class_group = Factory(:class_group)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Class Groups"}
  end

  context "listing class groups" do
    it "should list existing class groups" do
      page.should have_content "Class Listing"
    end
  end

  context "creating new class group" do 
    it "should create new class group" do 
      click_link "new_class_group_link"
      fill_in "class_group_name", :with => "Awesome class"
      click_button "Create Class group"

      page.should have_content "was successfully created"
    end
  end

  context "show class group" do
    it "should list existing enrolled students" do
      visit class_group_path(@class_group)
      page.should have_content "Class Roster"
      page.should have_link "Add Student"
    end

    it "should list existing semesters" do
      visit class_group_path(@class_group)
      page.should have_content "Semesters list"
      page.should have_link "Add a semester"
    end

    it "should list existing courses" do
      visit class_group_path(@class_group)
      page.should have_content "Courses List"
      page.should have_link "Add course"
    end
  end
end
