shared_examples 'new address' do
  
  context 'new' do
    
    before do
      click new_link
      wait_until_invisible new_link
      wait_until_visible submit  
    end

    it "creates and shows", js:true do

      fill_in "address_title", with: 'Primary address'
      select "#{address.country.name}", from: 'country_dropdown'
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

end

shared_examples_for 'delete address' do

  it "deletes", js:true do
    ensure_delete_is_working
    wait_until_visible new_link

    flash_destroyed?
  end

end