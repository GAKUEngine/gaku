require 'spec_helper'

describe 'Note' do
  stub_authorization!
  
  before do
    @student = Factory(:student)
    visit student_path(@student) 
  end

  it "should add and show student note", :js => true do
    @student.notes.size.should eql(0)
    click_link 'new-student-note-link'

    wait_until { find('#new-student-note-form').visible? } 
    fill_in "note_title", :with => "The note title"
    fill_in "note_content", :with => "The note content"
    click_button "submit-student-note-button"

    wait_until { !page.find('#new-student-note-form').visible? } 
    page.should have_selector('a', href: "/students/1/notes/1/edit")
    page.should have_content("The note title")
    page.should have_content("The note content")
    @student.reload
    @student.notes.size.should eql(1)
  end

  it "should not submit new note without filled validated fields", :js => true do 
    click_link 'new-student-note-link'

    wait_until { page.has_content?('New Note') } 
    click_button "submit-student-note-button"
    @student.notes.size.should eql(0)
  end

  context "edit and delete" do 
    before do 
      @note = Factory(:note, :student_id => @student)
      visit student_path(@student)
    end

    it "should edit a student note", :js => true do 
      click_link 'new-student-note-link'

      wait_until { page.has_content?('New Note') } 
      fill_in "note_title", :with => "The note title"
      fill_in "note_content", :with => "The note content"
      click_button "submit-student-note-button"
      find(".edit-link").click 

      wait_until { find('#edit-note-modal').visible? } 
      fill_in 'note_title', :with => 'Edited note title'
      fill_in 'note_content', :with => 'Edited note content'
      click_button 'submit-student-note-button'

      wait_until { !page.find('#edit-note-modal').visible? }
      page.should have_content('Edited note title')
      page.should have_content('Edited note content')
    end

    it "should delete a student note", :js => true do
      @student.notes.size.should eql(1)
      wait_until { page.has_content?('Notes') }
        
      tr_count = page.all('table#student-notes-index tr').size
      page.should have_content(@note.title)
      
      find('.delete-link').click 
      page.driver.browser.switch_to.alert.accept

      wait_until { page.all('table#student-notes-index tr').size == tr_count - 1 } 
      page.should_not have_content(@note.title)
      @student.notes.size.should eql(0)
    end
  end

end
