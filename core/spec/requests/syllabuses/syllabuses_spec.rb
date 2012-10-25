require 'spec_helper'

describe 'Syllabus' do
  form          = '#new-syllabus'
  new_link      = '#new-syllabus-link'
  modal         = '#syllabus-modal'
  
  cancel_link   = '#cancel-syllabus-link'
  submit_button = '#submit-syllabus-button'
  
  table_rows    = 'table#syllabuses-index tbody tr'
  count_div     = '.syllabuses-count'

  stub_authorization!

  before do
    @syllabus = create(:syllabus, :name => 'Biology', :code => 'bio')
    visit gaku.syllabuses_path
  end

  context "list and show syllabuses" do
    it "should list and show existing syllabuses" do
      page.should have_content("List Syllabuses")
      within('table#syllabuses-index tbody tr:nth-child(1)') { page.should have_content("Biology") }
      within('table#syllabuses-index tbody tr:nth-child(1)') { page.should have_content("bio") }
      
      # show
      within('table#syllabuses-index tbody tr:nth-child(1)') { find(".show-link").click }

      #TODO Make a real check when view is finished
      page.should have_content("Syllabus")
      page.should have_content("Biology")
      page.should have_content("bio")
    end
  end

  context "create and edit syllabus", :js => true do 
    it "should create new syllabus" do 
      click_link "new-syllabus-link"
      tr_count = page.all('table#syllabuses-index tbody tr').size
      wait_until { find("#submit-syllabus-button").visible? }
      fill_in "syllabus_name", :with => "Syllabus1"
      fill_in "syllabus_code", :with => "code1"
      fill_in "syllabus_description", :with => "Syllabus Description"
      click_button "submit-syllabus-button"
      wait_until { !page.find('#new-syllabus').visible? }
      page.find('#new-syllabus-link').visible?
      page.all('table#syllabuses-index tbody tr').size.should eq tr_count+1
      Syllabus.count.should eq 2
    end

    it "should not submit invalid syllabus", :js => true do 
      click_link "new-syllabus-link"
      wait_until { find("#submit-syllabus-button").visible? }
      click_button "submit-syllabus-button"
      page.should have_content "This field is required"
      page.should_not have_content "was successfully created"
    end

    context 'edit', :js => true do
      before do
        click edit_link
        wait_until_visible modal
      end

      it 'edits a syllabus' do 
        fill_in "syllabus_name", :with => "Maths"
        fill_in "syllabus_code", :with => "math"
        fill_in "syllabus_description", :with => "Maths Description"

        click submit_button

        page.should have_content("Maths")
        page.should have_content("math")

        page.should_not have_content "Biology"
        page.should_not have_content 'bio'

        edited_syllabus = Syllabus.last
        edited_syllabus.name.should eq 'Maths'
        edited_syllabus.code.should eq 'math'
        edited_syllabus.description.should eq 'Maths Description'
        flash_updated?
      end

      it 'cancels editting' do
        click cancel_link
        wait_until_invisible modal
      end

      it 'edits a syllabus from show view' do 
        visit gaku.syllabus_path(@syllabus)
        click edit_link
        wait_until_visible modal 

        fill_in "syllabus_name", :with => "Maths"
        fill_in "syllabus_code", :with => "math"
        fill_in "syllabus_description", :with => "Maths Description"

        click submit_button

        page.should have_content("Maths")
        page.should have_content("math")

        page.should_not have_content "Biology"
        page.should_not have_content 'bio'

        edited_syllabus = Syllabus.last
        edited_syllabus.name.should eq 'Maths'
        edited_syllabus.code.should eq 'math'
        edited_syllabus.description.should eq 'Maths Description'
        flash_updated?
      end
    end
  end

  it "should delete a syllabus" do
    Syllabus.count.should eql(1)
    tr_count =  page.all('table#syllabuses-index tbody tr').size
    within('table#syllabuses-index tbody tr:nth-child(1)') { find(".delete-link").click }
      
    wait_until { page.all('table#syllabuses-index tbody tr').size == tr_count - 1 }
    page.should_not have_content("#{@syllabus.code}")
    Syllabus.count.should eql(0)
  end

end