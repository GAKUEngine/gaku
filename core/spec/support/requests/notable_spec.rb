shared_examples_for 'new note' do
  
  context 'new' do
    
    before do
      click new_link
      wait_until_visible submit  
    end

    it "adds and shows", js: true do
      expect do
        fill_in "note_title",   with: "The note title"
        fill_in "note_content", with: "The note content"
        click submit
        wait_until_invisible submit
      end.to change(@data.notes, :count).by 1

      page.should have_content "The note title"
      page.should have_content "The note content"
      within(count_div) { page.should have_content 'Notes list(1)' }
      flash_created?
    end

    it 'cancels creating', js: true do
      ensure_cancel_creating_is_working
    end

    it 'has validations', js: true do
      has_validations?
    end

  end
  
end

shared_examples_for 'edit note' do
  
  before do
    within(table) { click edit_link }
    wait_until_visible modal
  end

  it "edits", js:true do
    fill_in 'note_title',   with: 'Edited note title'
    fill_in 'note_content', with: 'Edited note content'
    click submit

    wait_until_invisible modal
    page.should have_content 'Edited note title'
    page.should have_content 'Edited note content'
    flash_updated?
  end

  it 'cancels editting', js: true do
    ensure_cancel_modal_is_working
  end

  it 'errors without required fields', js:true do
    fill_in 'note_title', :with => ''
    has_validations?
  end

end

shared_examples_for 'delete note' do

  it "deletes", :js => true do
    note_field = @data.notes.first.title

    within(count_div) { page.should have_content 'Notes list(1)' }
    page.should have_content note_field

    expect do
      ensure_delete_is_working
    end.to change(@data.notes, :count).by -1

    within(count_div) { page.should_not have_content 'Notes list(1)' }
    page.should_not have_content note_field
    flash_destroyed?
  end

end