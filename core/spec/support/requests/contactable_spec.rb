shared_examples_for 'new contact' do

  it { has_validations? }
  
  context 'new' do
    
    before do
      click new_link
      wait_until_visible submit  
    end

    it "adds and shows" do
      expect do
        select 'Email',            :from => 'contact_contact_type_id'
        fill_in "contact_data",    :with => "The contact data"
        fill_in "contact_details", :with => "The contact details"
        click submit
        wait_until_invisible form
      end.to change(@data.contacts, :count).by 1

      page.should have_content "The contact data"
      page.should have_content "The contact details"
      within(count_div) { page.should have_content 'Contacts list(1)' }
      flash_created?
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end

  end
  
end

shared_examples_for 'edit contact' do
  
  before do
    within(table) { click edit_link }
    wait_until_visible modal
  end

  it "edits" do
    fill_in 'contact_data', :with => 'example@genshin.org'
    click submit

    wait_until_invisible modal
    page.should have_content 'example@genshin.org'
    flash_updated?
  end

  it 'cancels editting', :cancel => true do
    ensure_cancel_modal_is_working
  end

end

shared_examples_for 'delete contact' do

  it "deletes", :js => true do
    contact_field = @data.contacts.first.data

    within(count_div) { page.should have_content 'Contacts list(1)' }
    page.should have_content contact_field

    expect do
      ensure_delete_is_working
    end.to change(@data.contacts, :count).by -1

    within(count_div) { page.should_not have_content 'Contacts list(1)' }
    page.should_not have_content contact_field
    flash_destroyed?
  end

end

shared_examples_for 'primary contacts' do

  it "sets primary", :js => true do
    @data.contacts.first.primary? == true
    @data.contacts.second.primary? == false

    within("#{table} tr#contact-2") { click_link 'set-primary-link' }
    accept_alert

    @data.contacts.first.primary? == false
    @data.contacts.second.primary? == true
  end

  it "delete primary", :js => true do
    contact1_tr = "#contact-#{@data.contacts.first.id}"
    contact2_tr = "#contact-#{@data.contacts.second.id}"

    within("#{table} #{contact2_tr}") { click_link 'set-primary-link' }
    accept_alert

    !page.find("#{contact2_tr} td.primary-contact a.btn-primary")

    click "#{contact2_tr} .delete-link"
    accept_alert

    page.find("#{contact1_tr} .primary-contact a.btn-primary")
    @data.contacts.first.primary? == true
  end
end