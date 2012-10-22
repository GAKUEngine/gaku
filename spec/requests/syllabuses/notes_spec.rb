require 'spec_helper'

describe 'Syllabus Notes' do
  stub_authorization!
  
  before do
    @syllabus = create(:syllabus)
    visit syllabus_path(@syllabus) 
  end

  context 'new' do
    before do 
      click_link 'new-note-link'
      wait_until { find("#submit-syllabus-note-button").visible? }
    end

    it "should add and show syllabus note", :js => true do
      @syllabus.notes.size.should eql(0)
      tr_count = page.all('table#syllabus-notes-index tr').size
 
      fill_in "note_title", :with => "The note title"
      fill_in "note_content", :with => "The note content"
      click_button "submit-syllabus-note-button"

      wait_until { !page.find('#new-note form').visible? } 
      page.should have_selector('a', href: "/syllabuses/1/notes/1/edit")
      page.should have_content("The note title")
      page.should have_content("The note content")
      page.all('table#syllabus-notes-index tr').size == tr_count + 1
      within('.syllabus-notes-count') { page.should have_content('Notes list(1)') }
      @syllabus.reload
      @syllabus.notes.size.should eql(1)
    end

    it "should error if there are empty fields", :js => true do 
      click_button "submit-syllabus-note-button"
      wait_until do
         page.should have_selector('div.note_titleformError') 
         page.should have_selector('div.note_contentformError') 
      end
      @syllabus.notes.size.should eql(0)
    end

    it 'should cancel adding', :js => true do 
      click_link 'cancel-note-link'
      wait_until { !page.find('#new-note form').visible? }
      find('#new-note-link').visible?

      click_link 'new-note-link'
      wait_until { find('#new-note form').visible? }
      !page.find('#new-note-link').visible?
    end
  end

  context "edit and delete" do 
    before do 
      @note = create(:note, :notable => @syllabus)
      visit syllabus_path(@syllabus)
    end

    it "should edit a syllabus note", :js => true do 
      find(".edit-link").click 

      wait_until { find('#edit-note-modal').visible? } 
      fill_in 'note_title', :with => 'Edited note title'
      fill_in 'note_content', :with => 'Edited note content'
      click_button 'submit-syllabus-note-button'

      wait_until { !page.find('#edit-note-modal').visible? }
      page.should have_content('Edited note title')
      page.should have_content('Edited note content')
    end

    it 'should cancel editting', :js => true do
      find(".edit-link").click

      wait_until { find('#edit-note-modal').visible? }
      click_link 'cancel-syllabus-note-link'
      wait_until { !page.find('#edit-note-modal').visible? }
    end

    it "should delete a syllabus note", :js => true do
      @syllabus.notes.size.should eql(1)
      wait_until { page.has_content?('Notes') }
        
      tr_count = page.all('table#syllabus-notes-index tr').size
      page.should have_content(@note.title)
      
      find('.delete-link').click 
      page.driver.browser.switch_to.alert.accept

      wait_until { page.all('table#syllabus-notes-index tr').size == tr_count - 1 } 
      within('.syllabus-notes-count') { page.should_not have_content('Notes list(1)') }
      page.should_not have_content(@note.title)
      @syllabus.notes.size.should eql(0)
    end
  end
end