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
      end.to change(@data.contacts, :count).by 1

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

  before do
    within(table) { click edit_link }
    wait_until_visible modal
  end

  it 'edits' do
    fill_in 'contact_data', with: 'example@genshin.org'
    click submit

    wait_until_invisible modal
    has_content? 'example@genshin.org'
    flash_updated?
    expect(@data.contacts.first.reload.data).to eq 'example@genshin.org'
  end

  it 'errors without required fields', js:true do
    fill_in 'contact_data',  with: ''
    has_validations?
  end

end

shared_examples_for 'delete contact' do

  it 'deletes', js: true do
    contact_field = @data.contacts.first.data

    count? 'Contacts list(1)'
    if page.has_css?(tab_link)
      within(tab_link)  { has_content? 'Contacts(1)' }
    end
    has_content? contact_field

    expect do
      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(@data.contacts, :count).by(-1)
    end.to change(@data.contacts.deleted, :count).by(1)

    within(count_div) { has_no_content? 'Contacts list(1)' }
    if page.has_css?(tab_link)
      within(tab_link)  { has_no_content? 'Contacts(1)' }
    end
    has_no_content? contact_field
  end

end

shared_examples_for 'primary contacts' do

  it 'sets primary', js: true do
    expect(@data.contacts.first.primary?).to eq true
    expect(@data.contacts.second.primary?).to eq false

    within("#{table} tr#contact-2") { click_link 'set-primary-link' }
    accept_alert

    within("#{table} tr#contact-#{@data.contacts.second.id}") do
      expect(page).to have_css('.btn-primary')
    end

    @data.contacts.reload
    expect(@data.contacts.first.primary?).to eq false
    expect(@data.contacts.second.primary?).to eq true
  end

  it 'delete primary', js: true do
    contact1_tr = "#contact-#{@data.contacts.first.id}"
    contact2_tr = "#contact-#{@data.contacts.second.id}"

    within("#{table} #{contact2_tr}") { click_link 'set-primary-link' }
    accept_alert

    !page.find("#{contact2_tr} td.primary-contact a.btn-primary")

    click "#{contact2_tr} .delete-link"
    accept_alert

    page.find("#{contact1_tr} .primary-contact a.btn-primary")
    expect(@data.contacts.first.primary?).to eq true
  end
end
