require 'spec_helper'

describe 'Admin School Campuses Address' do

  stub_authorization!

  let(:address) { create(:address) }
  let(:school) { create(:school)}

  before :all do
    set_resource "admin-school-campus-address"
  end


  context 'new', :js => true do
    before do
      address
      visit gaku.admin_school_campus_path(school, school.master_campus)
      click new_link
      wait_until_invisible new_link
      wait_until_visible submit
    end

    it "creates and shows" do

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

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context "existing", :js => true do
    before do
      address.campus = school.master_campus
      school.master_campus.address = address
    end

    context 'edit' do
      before do
        visit gaku.admin_school_campus_path(school, school.master_campus)
        click edit_link
        wait_until_visible modal
      end

      it "edits" do
        fill_in "address_address1", with:'The address new details'
        click submit

        wait_until_invisible modal
        page.should have_content 'The address new details'

        flash_updated?
      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end

    it "deletes" do
      visit gaku.admin_school_campus_path(school, school.master_campus)

      ensure_delete_is_working
      wait_until_visible new_link

      flash_destroyed?
    end
  end
end
