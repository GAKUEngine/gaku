shared_examples_for 'new note' do

  context 'new' do

    before do
      click new_link
      wait_until_visible submit
    end

    it 'adds and shows', js: true do
      expect do
        expect do
          fill_in 'note_title',   with: 'The note title'
          fill_in 'note_content', with: 'The note content'
          click submit
          flash_created?
        end.to change(Gaku::Note, :count).by(1)
      end.to change(@resource.notes, :count).by(1)

      has_content? 'The note title'
      has_content? 'The note content'
      count? 'Notes list(1)'
      if page.has_css?(tab_link)
        within(tab_link)  { has_content? 'Notes(1)' }
      end
    end

    it 'has validations', js: true do
      has_validations?
    end

  end
end

shared_examples_for 'edit note' do

  let(:note) { @resource.notes.first }

  before do
    within(table) { click edit_link }
    wait_until_visible modal
  end

  it 'edits', js:true do
    old_note = note.title
    fill_in 'note_title',   with: 'Edited note title'
    fill_in 'note_content', with: 'Edited note content'
    click submit

    flash_updated?
    has_content? 'Edited note title'
    has_content? 'Edited note content'
    has_no_content? old_note
    expect(@resource.notes.first.reload.title).to eq 'Edited note title'
  end

  it 'errors without required fields', js:true do
    fill_in 'note_title', with: ''
    has_validations?
  end
end

shared_examples_for 'delete note' do

  it 'deletes', js: true do
    note_field = @resource.notes.first.title

    count? 'Notes list(1)'
    has_content? note_field

    expect do
      ensure_delete_is_working
      flash_destroyed?
    end.to change(@resource.notes, :count).by(-1)

    within(count_div) { has_no_content? 'Notes list(1)' }
    if page.has_css?(tab_link)
      within(tab_link)  { has_no_content? 'Notes(1)' }
    end
    has_no_content? note_field
  end

end