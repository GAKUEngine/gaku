shared_examples_for 'new contact' do

  context 'new' do

    before do
      click new_link
      wait_until_visible submit
    end

    it { has_validations? }

    it 'adds and shows' do
      expect do
        select 'Email',            from: 'contact_contact_type_id'
        fill_in 'contact_data',    with: 'The contact data'
        fill_in 'contact_details', with: 'The contact details'
        click submit
        flash_created?
      end.to change(@resource.contacts, :count).by 1

      has_content? 'The contact data'
      has_content? 'The contact details'

      count? 'Contacts list(1)'
      if page.has_css?(tab_link)
        within(tab_link)  { has_content? 'Contacts(1)' }
      end
    end
  end

end

shared_examples_for 'edit contact' do

  let(:contact) { @resource.contacts.first }

  before do
    within(table) { click edit_link }
    wait_until_visible modal
  end

  it 'edits' do
    old_contact = contact.data
    fill_in 'contact_data', with: 'example@genshin.org'
    click submit

    wait_until_invisible modal
    has_content? 'example@genshin.org'
    flash_updated?
    expect(@resource.contacts.first.reload.data).to eq 'example@genshin.org'
    has_no_content? old_contact
  end

  it 'errors without required fields', js:true do
    fill_in 'contact_data',  with: ''
    has_validations?
  end

end

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

  it 'sets primary', js: true do
    expect(@resource.contacts.first.primary?).to eq true
    expect(@resource.contacts.second.primary?).to eq false

    within("#{table} tr#contact-2") { click_link 'set-primary-link' }
    accept_alert

    within("#{table} tr#contact-#{@resource.contacts.second.id}") do
      expect(page).to have_css('.btn-primary')
    end

    @resource.contacts.reload
    expect(@resource.contacts.first.primary?).to eq false
    expect(@resource.contacts.second.primary?).to eq true
  end

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
