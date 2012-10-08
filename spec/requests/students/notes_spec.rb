require 'spec_helper'

describe 'Note' do
  stub_authorization!
  
  before do
    @student = create(:student)
    visit student_path(@student) 
  end

  context 'new' do
    before do 
      click_link 'new-student-note-link'
      wait_until { find('#new-student-note-form').visible? }
    end

    it "should add and show student note", :js => true do
      @student.notes.size.should eql(0)
      tr_count = page.all('table#student-notes-index tr').size
 
      fill_in "note_title", :with => "The note title"
      fill_in "note_content", :with => "The note content"
      click_button "submit-student-note-button"

      wait_until { !page.find('#new-student-note-form').visible? } 
      page.should have_selector('a', href: "/students/1/notes/1/edit")
      page.should have_content("The note title")
      page.should have_content("The note content")
      page.all('table#student-notes-index tr').size == tr_count + 1
      within('.student-notes-count') { page.should have_content('Notes list(1)') }
      @student.reload
      @student.notes.size.should eql(1)
    end

    it "should error if there are empty fields", :js => true do 
      click_button "submit-student-note-button"
      wait_until do
         page.should have_selector('div.note_titleformError') 
         page.should have_selector('div.note_contentformError') 
      end
      @student.notes.size.should eql(0)
    end

    it 'should cancel adding', :js => true do 
      click_link 'cancel-student-note-link'
      wait_until { !page.find('#new-student-note-form').visible? }
      find('#new-student-note-link').visible?

      click_link 'new-student-note-link'
      wait_until { find('#new-student-note-form').visible? }
      !page.find('#new-student-note-link').visible?
    end
  end

  context "edit and delete" do 
    before do 
      @note = create(:note, :student_id => @student)
      visit student_path(@student)
    end

    it "should edit a student note", :js => true do 
      find(".edit-link").click 

      wait_until { find('#edit-note-modal').visible? } 
      fill_in 'note_title', :with => 'Edited note title'
      fill_in 'note_content', :with => 'Edited note content'
      click_button 'submit-student-note-button'

      wait_until { !page.find('#edit-note-modal').visible? }
      page.should have_content('Edited note title')
      page.should have_content('Edited note content')
    end

    it 'should cancel editting', :js => true do
      find(".edit-link").click

      wait_until { find('#edit-note-modal').visible? }
      click_link 'cancel-student-note-link'
      wait_until { !page.find('#edit-note-modal').visible? }
    end

    it "should delete a student note", :js => true do
      @student.notes.size.should eql(1)
      wait_until { page.has_content?('Notes') }
        
      tr_count = page.all('table#student-notes-index tr').size
      page.should have_content(@note.title)
      
      find('.delete-link').click 
      page.driver.browser.switch_to.alert.accept

      wait_until { page.all('table#student-notes-index tr').size == tr_count - 1 } 
      within('.student-notes-count') { page.should_not have_content('Notes list(1)') }
      page.should_not have_content(@note.title)
      @student.notes.size.should eql(0)
    end
  end

end
