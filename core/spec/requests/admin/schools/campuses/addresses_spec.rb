require 'spec_helper'

describe 'Admin School Campuses Address' do

  let(:address) { create(:address, country: country) }
  let(:school) { create(:school)}

  let!(:country) { create(:country, name: 'USA', iso: 'US') }
  let(:country_without_state) { create(:country, name: 'Japan', iso: 'JP') }
  let!(:state) { create(:state, country: country) }

  before(:all) { set_resource 'admin-school-campus-address' }
  before { as :admin }

  context 'new', type: 'address', js: true do
    before do
      country_without_state
      visit gaku.admin_school_campus_path(school, school.master_campus)
      click new_link
      wait_until_invisible new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      fill_in 'address_title',    with: 'Primary address'
      select "#{country}",        from: 'country_dropdown'
      fill_in 'address_zipcode',  with: '123'
      fill_in 'address_city',     with: 'Nagoya'
      fill_in 'address_address1', with: 'The address details'
      click submit

      flash_created?
      has_content? 'Primary address'
      expect(school.master_campus.address.address1).to eq 'The address details'
    end

    it 'has validations' do
      click submit
      has_validations?
    end

    it 'changes country with state' do
      select "#{country}", from: 'country_dropdown'
      within('#state-dropdown') { has_content? state.name }
      select "#{state}", from: 'address_state_id'
    end

    it 'changes country without state' do
      select "#{country_without_state}", from: 'country_dropdown'
      within('#state-dropdown') do
        expect(page).to have_css('select#address_state_id[disabled]')
        has_no_content? state.name
      end
    end

  end

  context 'existing', js: true, type: 'address' do

    before do
      school.master_campus.address = address
      visit gaku.admin_school_campus_path(school, school.master_campus)
    end

    context 'edit' do
      before do
        country_without_state
        click edit_link
        wait_until_visible modal
      end

      it 'edits' do
        old_address = address.address1

        fill_in 'address_address1', with:'The address new details'
        click submit

        flash_updated?
        expect(address.reload.address1).to eq 'The address new details'
        has_content? 'The address new details'
        has_no_content? old_address
      end

      it 'errors without required fields' do
        fill_in 'address_address1',  with: ''
        fill_in 'address_city',      with: ''

        has_validations?
      end

      it 'changes country with state' do
        select "#{country}", from: 'country_dropdown'
        within('#state-dropdown') { has_content? state.name }
        select "#{state}", from: 'address_state_id'
      end

      it 'changes country without state' do
        #select "#{country}", from: 'country_dropdown'
        select "#{country_without_state}", from: 'country_dropdown'
        within('#state-dropdown') do
          expect(page).to have_css('select#address_state_id[disabled]')
          has_no_content? state.name
        end
      end

    end

    it 'deletes single address' do
      ensure_delete_is_working
      wait_until_visible new_link

      flash_destroyed?
    end

  end
end
