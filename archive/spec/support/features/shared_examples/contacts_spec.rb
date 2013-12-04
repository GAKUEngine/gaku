shared_examples_for 'delete contact' do

  it 'deletes', js: true do
    contact_field = @resource.contacts.first.data

    count? 'Contacts list(1)'
    if page.has_css?(tab_link)
      within(tab_link)  { has_content? 'Contacts(1)' }
    end
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

shared_examples_for 'primary contacts' do

  it 'delete primary', js: true do
    contact1_tr = "#contact-#{@resource.contacts.first.id}"
    contact2_tr = "#contact-#{@resource.contacts.second.id}"

    within("#{table} #{contact2_tr}") { click_link 'set-primary-link' }
    accept_alert

    !page.find("#{contact2_tr} td.primary-contact a.btn-primary")

    click "#{contact2_tr} .delete-link"
    accept_alert

    page.find("#{contact1_tr} .primary-contact a.btn-primary")
    expect(@resource.contacts.first.primary?).to eq true
  end
end
