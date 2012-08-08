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

    page.should have_selector('a', href: "/students/1/notes/1/edit")
    page.should have_content("The note title")
    page.should have_content("The note content")
    @student.notes.size.should == 1

  end

  it "should edit a student note", :js => true do 
    Factory(:note, :student_id => @student)
    visit student_path(@student) 

    click_link 'new_student_note_tab_link'
    click_link 'new_student_note_link'

    wait_until { page.has_content?('New Note') } 

    click_link "Edit" 

    wait_until { find('#editNoteModal').visible? } 
    fill_in 'note_title', :with => 'Edited note title'
    fill_in 'note_content', :with => 'Edited note content'

    click_button 'submit_button'
    click_link 'cancel_link'
    wait_until { !page.find('#editNoteModal').visible? }

    page.should have_content('Edited note title')
    page.should have_content('Edited note content')

  end
end