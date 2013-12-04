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