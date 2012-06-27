require 'spec_helper'

describe 'ClassGroups' do
  before do
    @syllabus = Factory(:class_group)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Class Listing"}
  end

  context "listing class groups" do
    it "should list existing class groups" do

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
end