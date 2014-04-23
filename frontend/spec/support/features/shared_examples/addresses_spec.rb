shared_examples 'new address' do

  context 'new' do

    before do
      click new_link
    end

    it 'creates and shows', js:true do
      expect do
        fill_in 'address_title',    with: 'Primary address'
        select "#{country}",        from: 'country_dropdown'
        fill_in 'address_zipcode',  with: '123'
        fill_in 'address_city',     with: 'Nagoya'
        fill_in 'address_address1', with: 'The address details'
        click submit

        flash_created?
      end.to change(@resource.addresses, :count).by(1)

      has_content? 'Primary address'
      count? 'Addresses list(1)'
      if page.has_css?(tab_link)
        within(tab_link)  { has_content? 'Addresses(1)' }
      end
    end

    it 'has validations', js:true do
      expect do
        click submit
        has_validations?
      end.to_not change(@resource.addresses, :count)
    end

  end
end

shared_examples_for 'edit address' do

  let(:address) { @resource.addresses.first }

  before do
    click js_edit_link
    page.has_selector? modal
  end

  it 'edits', js:true do
    old_address = address.address1

    fill_in 'address_address1', with:'The address new details'
    click submit

    flash_updated?
    expect(address.reload.address1).to eq 'The address new details'
    has_content? 'The address new details'
    has_no_content? old_address
  end


  it 'errors without required fields', js:true do
    fill_in 'address_address1',  with: ''
    fill_in 'address_city',      with: ''

    has_validations?
  end

end

shared_examples_for 'delete address' do

  it 'deletes', js: true do
    address_field = @resource.addresses.first.address1

    count? 'Addresses list(1)'
    if page.has_css?(tab_link)
      within(tab_link)  { has_content? 'Addresses(1)' }
    end
    has_content? address_field

    expect do
      ensure_delete_is_working
      flash_destroyed?
    end.to change(@resource.addresses, :count).by(-1)

    count? 'Addresses list(1)'
    has_no_content? address_field
    if page.has_css?(tab_link)
      within(tab_link)  { has_no_content? 'Addresses(1)' }
    end
  end

end

shared_examples_for 'primary addresses' do

  it 'sets primary', js: true do
    old_primary = @resource.addresses.primary
    old_secondary = @resource.addresses.secondary.first

    expect(old_primary.primary).to eq true
    expect(old_secondary.primary).to eq false

    within("#{table} tr#address-#{old_secondary.id}") { click_link 'set_primary_link' }

    accept_alert

    within("#{table} tr#address-#{old_secondary.id}") do
      expect(page).to have_css('.btn-primary')
    end

    expect(old_primary.reload.primary).to eq false
    expect(old_secondary.reload.primary).to eq  true
  end

  it 'delete primary', js: true do
    old_primary = @resource.addresses.primary
    old_secondary = @resource.addresses.secondary.first

    address_pri_tr = "#address-#{old_primary.id}"
    address_sec_tr = "#address-#{old_secondary.id}"

    within("#{table} #{address_pri_tr}") { click '.delete-link'}
    accept_alert

    page.find("#{address_sec_tr} .primary_address a.btn-primary")

    expect(old_secondary.reload.primary).to eq true
  end
end

shared_examples_for 'dynamic state dropdown' do

  let!(:country_without_state) { create(:country, name: 'USA', iso: 'US') }
  let!(:state) { create(:state, name: 'Florida', country: country) }

  context 'new form' do
    before { click new_link }

    it 'changes country with state', js: true do
      select "#{country}", from: 'country_dropdown'
      within('#state-dropdown') { has_content? state.name }
      select "#{state.name}", from: 'address_state_id'
    end


    it 'changes country without state',js: true do
      select "#{country_without_state}", from: 'country_dropdown'
      within('#state-dropdown') do
        expect(page).to have_css('select#address_state_id[disabled]')
        has_no_content? state.name
      end
    end
  end

  context 'edit form' do
    before { click js_edit_link }

    it 'changes country with state',js: true do
      select "#{country}", from: 'country_dropdown'
      within('#state-dropdown') { has_content? state.name }
      select "#{state.name}", from: 'address_state_id'
    end


    it 'changes country without state', js: true do
      select "#{country_without_state}", from: 'country_dropdown'
      within('#state-dropdown') do
        expect(page).to have_css('select#address_state_id[disabled]')
        has_no_content? state.name
      end
    end
  end

end

