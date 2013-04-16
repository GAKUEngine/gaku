shared_examples 'new address' do

  context 'new' do

    before do
      click new_link
      wait_until_invisible new_link
      wait_until_visible submit
    end

    it "creates and shows", js:true do

      fill_in "address_title", with: 'Primary address'
      select "#{country}", from: 'country_dropdown'
      fill_in "address_zipcode", with:'123'
      fill_in "address_city", with:'Nagoya'
      fill_in "address_address1", with:'The address details'
      click submit
      wait_until_invisible form

      page.should have_content "Primary address"
      flash_created?
    end

    it 'cancels creating', js:true do
      ensure_cancel_creating_is_working
    end

    it 'has validations', js:true do
      click submit
      has_validations?
    end

  end

end

shared_examples_for 'edit address' do

  before do
    click edit_link
    wait_until_visible modal
  end

  it "edits", js:true do
    fill_in "address_address1", with:'The address new details'
    click submit

    wait_until_invisible modal
    page.should have_content 'The address new details'

    flash_updated?
  end

  it 'cancels editting', js:true do
    ensure_cancel_modal_is_working
  end

  it 'errors without required fields', js:true do
    fill_in 'address_address1',  :with => ''
    fill_in 'address_city',      :with => ''

    has_validations?
  end

end

shared_examples_for 'delete address' do

  it "deletes", :js => true do
    address_field = @data.addresses.first.address1

    within(count_div) { page.should have_content 'Addresses list(1)' }
    page.should have_content address_field

    expect do
      ensure_delete_is_working
    end.to change(@data.addresses, :count).by -1

    within(count_div) { page.should_not have_content 'Addresses list(1)' }
    page.should_not have_content address_field
    flash_destroyed?
  end

end

shared_examples_for 'primary addresses' do

  it "sets primary", :js => true do
    @data.addresses.first.primary? == true
    @data.addresses.second.primary? == false

    within("#{table} tr#address-#{@data.addresses.second.id}") { click_link 'set_primary_link' }
    accept_alert

    @data.addresses.first.primary? == false
    @data.addresses.second.primary? == true
  end

  it "delete primary", :js => true do
    address1_tr = "#address-#{@data.addresses.first.id}"
    address2_tr = "#address-#{@data.addresses.second.id}"

    within("#{table} #{address2_tr}") { click_link 'set_primary_link' }
    accept_alert

    page.find("#{address2_tr} .primary_address a.btn-primary")

    within("#{table} #{address2_tr}") { click '.delete-link'}
    accept_alert

    page.find("#{address1_tr} .primary_address a.btn-primary")

    @data.addresses.first.primary? == true
  end
end
