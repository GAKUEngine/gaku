require 'spec_helper'

describe 'Syllabus' do
  before do
    @syllabus = Factory(:syllabus)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "List Syllabus"}
  end

  context "listing syllabuses" do
    it "should list existing syllabuses" do

    end
  end

  context "creating new syllabus" do 
    it "should create new syllabus" do 
      click_link "new_syllabus_link"
      fill_in "syllabus_name", :with => "Syllabus1"
      fill_in "syllabus_description", :with => "Syllabus Description"
      click_button "Create Syllabus"

      page.should have_content "was successfully created"

    end
  end
end