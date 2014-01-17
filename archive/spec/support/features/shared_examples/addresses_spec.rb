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
