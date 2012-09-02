require 'spec_helper'

describe 'Note' do
  stub_authorization!
  
  before do
    @student = Factory(:student)
    #within('ul#menu') { click_link "Students" }
    visit student_path(@student) 
  end

  it "should add and show student note", :js => true do
    
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

  it "should not submit new note without filled validated fields", :js => true do 
    click_link 'new_student_note_tab_link'
    click_link 'new_student_note_link'

    wait_until { page.has_content?('New Note') } 
  
    click_button "Save note"
    @student.notes.size.should == 0
  end

  context "edit and delete" do 
    before do 
      @note = Factory(:note, :student_id => @student)
      visit student_path(@student)
    end

    it "should edit a student note", :js => true do 
      click_link 'new_student_note_tab_link'
      click_link 'new_student_note_link'

      wait_until { page.has_content?('New Note') } 
      fill_in "note_title", :with => "The note title"
      fill_in "note_content", :with => "The note content"

      click_button "Save note"
      click_link "edit_link" 

      wait_until { find('#editNoteModal').visible? } 
      fill_in 'note_title', :with => 'Edited note title'
      fill_in 'note_content', :with => 'Edited note content'

      click_button 'submit_button'
      wait_until { !page.find('#editNoteModal').visible? }
      
      page.should have_content('Edited note title')
      page.should have_content('Edited note content')
    end

    it "should delete a student note", :js => true do
      click_link 'new_student_note_tab_link'
      wait_until { page.has_content?('Notes') }
        
      tr_count = page.all('table.index tr').size
      page.should have_content(@note.title)
      @student.notes.size.should == 1

      click_link 'delete_link' 
      page.driver.browser.switch_to.alert.accept

      wait_until { page.all('table.index tr').size == tr_count - 1 } 
      @student.notes.size.should == 0
      page.should_not have_content(@note.title)
    end
  end

end
