require 'spec_helper'

describe 'Syllabus' do
  before do
    @syllabus = Factory(:syllabus, :name => 'Biology', :code => 'bio')
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Syllabuses"}
  end

  context "list and show syllabuses" do
    it "should list and show existing syllabuses" do
      page.should have_content("List Syllabuses")
      within('table.index tr:nth-child(2)') { page.should have_content("Biology") }
      within('table.index tr:nth-child(2)') { page.should have_content("bio") }
      
      # show
      within('table.index tr:nth-child(2)') { click_link "show" }

      #TODO Make a real check when view is finished
      page.should have_content("Syllabus")
      page.should have_content("Biology")
      page.should have_content("bio")

    end
  end

  context "create and edit syllabus" do 
    it "should create new syllabus" do 
      click_link "new_syllabus_link"
      fill_in "syllabus_name", :with => "Syllabus1"
      fill_in "syllabus_code", :with => "code1"
      fill_in "syllabus_description", :with => "Syllabus Description"
      click_button "Create Syllabus"

      page.should have_content "was successfully created"
    end

    it "should edit syllabus" do 
      within('table.index tr:nth-child(2)') { click_link "edit" }
      fill_in "syllabus_name", :with => "Biology1"
      fill_in "syllabus_code", :with => "bio1"
      fill_in "syllabus_description", :with => "Biology Description"
      click_button "Update Syllabus"

      page.should have_content("was successfully updated")
      page.should have_content("Biology1")
      page.should have_content("bio1")
    end
  end
end