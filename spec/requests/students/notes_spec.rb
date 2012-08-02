require 'spec_helper'

describe 'Note' do
  
  before do
    @student = Factory(:student)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Students" }
  end

  it "should add and show student note", :js => true do
    visit student_path(@student) 

    click_link 'new_student_note_tab_link'
    click_link 'new_student_note_link'

    wait_until { page.has_content?('New Note') } 

    fill_in "note_title", :with => "The note title"
    fill_in "note_content", :with => "The note content"

    click_button "Save note"

    @student.notes.size.should == 1
    page.should have_selector('a', href: "/students/1/notes/1/edit")

    page.should have_content("The note title")
    page.should have_content("The note content")

  end
end