shared_examples_for 'new contact' do

  context 'new' do

    before do
      click new_link
      visible? submit
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
      within('.contacts-count') { expect(page.has_content?('1')).to eq true }
    end
  end

end

shared_examples_for 'edit contact' do

  let(:contact) { @resource.contacts.first }

  before do
    within(table) { click js_edit_link }
    visible? modal
  end

  it 'edits' do
    old_contact = contact.data
    fill_in 'contact_data', with: 'example@genshin.org'
    click submit

    invisible? modal
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
      ensure_delete_is_working
      flash_destroyed?
    end.to change(@resource.contacts, :count).by(-1)

    within('.contacts-count') { expect(page.has_no_content?('1')).to eq true }

    within(count_div) { has_no_content? 'Contacts list(1)' }
    has_no_content? contact_field
  end

end

shared_examples_for 'primary contacts' do

  it 'sets primary', js: true do
    old_primary = @resource.contacts.primary
    old_secondary = @resource.contacts.secondary.first

    expect(old_primary.primary).to eq true
    expect(old_secondary.primary).to eq false

    within("#{table} tr#contact-#{old_secondary.id}") { click_link 'set-primary-link' }
    accept_alert

    within("#{table} tr#contact-#{old_secondary.id}") do
      expect(page).to have_css('.btn-primary')
    end

    old_primary.reload
    old_secondary.reload

    expect(old_primary.primary).to eq false
    expect(old_secondary.primary).to eq true
  end

  it 'delete primary', js: true do
    old_primary = @resource.contacts.primary
    old_secondary  = @resource.contacts.secondary.first

    contact_pri_tr = "#contact-#{old_primary.id}"
    contact_sec_tr = "#contact-#{old_secondary.id}"

    click "#{contact_pri_tr} .delete-link"
    accept_alert

    page.find("#{contact_sec_tr} .primary-contact a.btn-primary")

    expect(old_secondary.reload.primary).to eq true
    within('.contacts-count') { expect(page.has_content?('1')).to eq true }
  end
end