require 'spec_helper'

describe 'Syllabus' do
  stub_authorization!

  before do
    @syllabus = create(:syllabus, :name => 'Biology', :code => 'bio')
    visit syllabuses_path
  end

  context "list and show syllabuses" do
    it "should list and show existing syllabuses" do
      page.should have_content("List Syllabuses")
      within('table#syllabuses-index tr:nth-child(2)') { page.should have_content("Biology") }
      within('table#syllabuses-index tr:nth-child(2)') { page.should have_content("bio") }
      
      # show
      within('table#syllabuses-index tr:nth-child(2)') { find(".show-link").click }

      #TODO Make a real check when view is finished
      page.should have_content("Syllabus")
      page.should have_content("Biology")
      page.should have_content("bio")
    end
  end

  context "create and edit syllabus", :js => true do 
    it "should create new syllabus" do 
      click_link "new-syllabus-link"
      tr_count = page.all('table#syllabuses-index tr').size
      wait_until { find("#submit-syllabus-button").visible? }
      fill_in "syllabus_name", :with => "Syllabus1"
      fill_in "syllabus_code", :with => "code1"
      fill_in "syllabus_description", :with => "Syllabus Description"
      click_button "submit-syllabus-button"
      wait_until { !page.find('#new-syllabus').visible? }
      page.find('#new-syllabus-link').visible?
      page.all('table#syllabuses-index tr').size.should eq tr_count+1
      Syllabus.count.should eq 2
    end

    it "should not submit invalid syllabus", :js => true do 
      click_link "new-syllabus-link"
      wait_until { find("#submit-syllabus-button").visible? }
      click_button "submit-syllabus-button"
      page.should have_content "This field is required"
      page.should_not have_content "was successfully created"
    end

    pending "should edit a syllabus" do 
      within('table#syllabuses-index tr:nth-child(2)') { find(".edit-link").click }
      fill_in "syllabus_name", :with => "Biology1"
      fill_in "syllabus_code", :with => "bio1"
      fill_in "syllabus_description", :with => "Biology Description"
      click_button "submit-syllabus-button"

      #page.should have_content("was successfully updated")
      page.should have_content("Biology1")
      page.should have_content("bio1")
    end

    it "should redirect to edit veiw when click to syllabus code link in index table" do
      within('table.index tr:nth-child(2)') { click_link "#{@syllabus.code}"}
      page.should have_content("Edit Syllabus")
    end

    it "should redirect to edit view when click on Edit button in show view" do
      within('table.index tr:nth-child(2)') { find(".show-link").click }
      find(".edit-link").click
      page.should have_content("Edit Syllabus")
    end
  end

  it "should delete a syllabus" do
    Syllabus.count.should eql(1)
    tr_count =  page.all('table#syllabuses-index tr').size
    within('table#syllabuses-index  tr:nth-child(2)') { find(".delete-link").click }
      
    wait_until { page.all('table#syllabuses-index tr').size == tr_count - 1 }
    page.should_not have_content("#{@syllabus.code}")
    Syllabus.count.should eql(0)
  end

end