shared_examples 'new address' do

  context 'new' do

    before do
      click new_link
      wait_until_invisible new_link
      wait_until_visible submit
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
    click edit_link
    wait_until_visible modal
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
    within(tab_link)  { has_content? 'Addresses(1)' }
    has_content? address_field

    expect do
      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(@resource.addresses, :count).by(-1)
    end.to change(@resource.addresses.deleted, :count).by(1)

    count? 'Addresses list(1)'
    has_no_content? address_field
    within(tab_link)  { has_no_content? 'Addresses(1)' }
  end

end

shared_examples_for 'primary addresses' do

  it 'sets primary', js: true do
    expect(@resource.addresses.first.primary?).to eq true
    expect(@resource.addresses.second.primary?).to eq false

    within("#{table} tr#address-#{@resource.addresses.second.id}") { click_link 'set_primary_link' }

    accept_alert

    within("#{table} tr#address-#{@resource.addresses.second.id}") do
      expect(page).to have_css('.btn-primary')
    end

    @resource.addresses.reload
    expect(@resource.addresses.first.primary?).to eq false
    expect(@resource.addresses.second.primary?).to eq  true
  end

  it 'delete primary', js: true do
    address1_tr = "#address-#{@resource.addresses.first.id}"
    address2_tr = "#address-#{@resource.addresses.second.id}"

    within("#{table} #{address2_tr}") { click_link 'set_primary_link' }
    accept_alert

    page.find("#{address2_tr} .primary_address a.btn-primary")

    within("#{table} #{address2_tr}") { click '.delete-link'}
    accept_alert

    page.find("#{address1_tr} .primary_address a.btn-primary")

    expect(@resource.addresses.first.primary?).to eq true
  end
end

shared_examples_for 'dynamic state dropdown' do

  let!(:country_without_state) { create(:country, name: 'USA', iso: 'US') }
  let!(:state) { create(:state, country: country) }

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
    before { click edit_link }

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

