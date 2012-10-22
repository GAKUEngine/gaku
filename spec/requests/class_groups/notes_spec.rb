require 'spec_helper'

describe 'ClassGroup Notes' do
  stub_authorization!
  
  before do
    @class_group = create(:class_group)
    visit class_group_path(@class_group) 
  end

  context 'new' do
    before do 
      click_link 'new-note-link'
      wait_until { find("#submit-classgroup-note-button").visible? }
    end

    it "should add and show class group note", :js => true do
      @class_group.notes.size.should eql(0)
      tr_count = page.all('table#class_group-notes-index tr').size
 
      fill_in "note_title", :with => "The note title"
      fill_in "note_content", :with => "The note content"
      click_button "submit-classgroup-note-button"

      wait_until { !page.find('#new-note form').visible? } 
      page.should have_selector('a', href: "/class_groups/1/notes/1/edit")
      page.should have_content("The note title")
      page.should have_content("The note content")
      page.all('table#class_group-notes-index tr').size == tr_count + 1
      within('.classgroup-notes-count') { page.should have_content('Notes list(1)') }
      @class_group.reload
      @class_group.notes.size.should eql(1)
    end

    it "should error if there are empty fields", :js => true do 
      click_button "submit-classgroup-note-button"
      wait_until do
         page.should have_selector('div.note_titleformError') 
         page.should have_selector('div.note_contentformError') 
      end
      @class_group.notes.size.should eql(0)
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
      @note = create(:note, :notable => @class_group)
      visit class_group_path(@class_group)
    end

    it "should edit a class group note", :js => true do 
      find(".edit-link").click 

      wait_until { find('#edit-note-modal').visible? } 
      fill_in 'note_title', :with => 'Edited note title'
      fill_in 'note_content', :with => 'Edited note content'
      click_button 'submit-classgroup-note-button'

      wait_until { !page.find('#edit-note-modal').visible? }
      page.should have_content('Edited note title')
      page.should have_content('Edited note content')
    end

    it 'should cancel editting', :js => true do
      find(".edit-link").click

      wait_until { find('#edit-note-modal').visible? }
      click_link 'cancel-classgroup-note-link'
      wait_until { !page.find('#edit-note-modal').visible? }
    end

    it "should delete a class group note", :js => true do
      @class_group.notes.size.should eql(1)
      wait_until { page.has_content?('Notes') }
        
      tr_count = page.all('table#classgroup-notes-index tr').size
      page.should have_content(@note.title)
      
      find('.delete-link').click 
      page.driver.browser.switch_to.alert.accept

      wait_until { page.all('table#classgroup-notes-index tr').size == tr_count - 1 } 
      within('.classgroup-notes-count') { page.should_not have_content('Notes list(1)') }
      page.should_not have_content(@note.title)
      @class_group.notes.size.should eql(0)
    end
  end
end