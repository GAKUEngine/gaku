shared_examples_for 'delete contact' do

  it 'deletes', js: true do
    contact_field = @resource.contacts.first.data

    count? 'Contacts list(1)'
    within(tab_link)  { has_content? 'Contacts(1)' } if page.has_css?(tab_link)
    has_content? contact_field

    expect do
      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(@resource.contacts, :count).by(-1)
    end.to change(@resource.contacts.deleted, :count).by(1)

    within(count_div) { has_no_content? 'Contacts list(1)' }
    if page.has_css?(tab_link)
      within(tab_link)  { has_no_content? 'Contacts(1)' }
    end
    has_no_content? contact_field
  end

end
