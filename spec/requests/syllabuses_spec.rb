require 'spec_helper'

describe 'Syllabus' do
  stub_authorization!

  before do
    @syllabus = Factory(:syllabus, :name => 'Biology', :code => 'bio')
    visit syllabuses_path
  end

  context "list and show syllabuses" do
    it "should list and show existing syllabuses" do
      page.should have_content("List Syllabuses")
      within('table#syllabuses-index tr:nth-child(2)') { page.should have_content("Biology") }
      within('table#syllabuses-index tr:nth-child(2)') { page.should have_content("bio") }
      
      # show
      within('table#syllabuses-index tr:nth-child(2)') { click_link "show-syllabus-link" }

      #TODO Make a real check when view is finished
      page.should have_content("Syllabus")
      page.should have_content("Biology")
      page.should have_content("bio")
    end
  end

  context "create and edit syllabus" do 
    it "should create new syllabus" do 
      click_link "new-syllabus-link"
      fill_in "syllabus_name", :with => "Syllabus1"
      fill_in "syllabus_code", :with => "code1"
      fill_in "syllabus_description", :with => "Syllabus Description"
      click_button "submit-syllabus-button"

      page.should have_content "was successfully created"
    end

    it "should not submit new syllabus without filled validated fields" do 
      click_link "new-syllabus-link"
      click_button "submit-syllabus-button"
      page.should_not have_content "was successfully created"
    end

    it "should edit a syllabus" do 
      within('table#syllabuses-index tr:nth-child(2)') { click_link "edit-syllabus-link" }
      fill_in "syllabus_name", :with => "Biology1"
      fill_in "syllabus_code", :with => "bio1"
      fill_in "syllabus_description", :with => "Biology Description"
      click_button "submit-syllabus-button"

      page.should have_content("was successfully updated")
      page.should have_content("Biology1")
      page.should have_content("bio1")
    end

    it "should redirect to edit veiw when click to syllabus code link in index table" do
      within('table.index tr:nth-child(2)') { click_link "#{@syllabus.code}"}
      page.should have_content("Edit Syllabus")
    end

    it "should redirect to edit view when click on Edit button in show view" do
      within('table.index tr:nth-child(2)') { click_link "show-syllabus-link" }
      click_on "edit-syllabus-link"
      page.should have_content("Edit Syllabus")
    end
  end

  it "should delete a syllabus" do
    Syllabus.count.should eql(1)
    tr_count =  page.all('table#syllabuses-index tr').size
    within('table#syllabuses-index  tr:nth-child(2)') { click_link "delete-syllabus-link" }
      
    wait_until { page.all('table#syllabuses-index tr').size == tr_count - 1 }
    page.should_not have_content("#{@syllabus.code}")
    Syllabus.count.should eql(0)
  end


end