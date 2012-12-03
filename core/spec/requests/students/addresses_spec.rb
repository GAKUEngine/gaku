require 'spec_helper'

describe 'Address' do
  stub_authorization!

  let(:student) { create(:student) }
  let(:country) { create(:country, :name => "Japan") }
  let(:address) { create(:address) }
  let(:student_address) { create(:student_address, :student => student, :address => address) }
  let(:bulgaria) { create(:country, :name => 'Bulgaria') }
  let(:address2) { create(:address, :address1 => 'Maria Luiza blvd.', :city => 'Varna', :country => bulgaria) }
  let(:student_address2) { create(:student_address, :student => student, :address => address2) }

  before :all do
    set_resource "student-address"
  end

  context 'new', :js => true do
    before do
      country
      visit gaku.student_path(student)

      click tab_link
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        #required
        select "Japan",             :from => 'country_dropdown'
        fill_in "address_city",     :with => "Nagoya"
        fill_in "address_address1", :with => "Subaru str."

        fill_in "address_title",    :with => "John Doe main address"
        fill_in "address_zipcode",  :with => "00359"
        fill_in "address_address2", :with => "Toyota str."

        click submit
        wait_until_invisible form
      end.to change(student.addresses, :count).by 1

      #required
      page.should have_content "Japan"
      page.should have_content "Nagoya"
      page.should have_content "Subaru str."

      page.should have_content "John Doe main address"
      page.should have_content "00359"
      page.should have_content "Toyota str."

      within(count_div) { page.should have_content 'Addresses list(1)' }
      within(tab_link)  { page.should have_content 'Addresses(1)' }
      flash_created?
    end

    pending 'errors without required fields' do
      click submit
      wait_until do
        flash_error_for 'address_address1'
        flash_error_for 'country_dropdown'
        flash_error_for 'address_city'
      end
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before(:each) do
      student_address
      visit gaku.student_path(student)
      click tab_link
      wait_until { page.has_content?('Addresses list') }
    end

    context 'edit', :js => true do
      before do
        click edit_link
        wait_until_visible modal
      end

      it 'edits' do
        fill_in 'address_address1',  :with => 'Edited street address'
        fill_in 'address_city',      :with => 'Tokyo'
        fill_in 'address_title',     :with => 'Edited address'

        click submit
        wait_until_invisible modal

        page.should have_content 'Edited street address'
        page.should have_content 'Tokyo'
        page.should have_content 'Edited address'
        flash_updated?
      end

      pending 'errors without required fields' do
        fill_in 'address_address1',  :with => ''
        fill_in 'address_city',      :with => ''

        click submit

        page.should have_content 'Address1 can\'t be blank'
        page.should have_content 'City can\'t be blank'
      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes', :js => true do
      within(tab_link)  { page.should have_content 'Addresses(1)' }
      within(count_div) { page.should have_content 'Addresses list(1)' }
      page.should have_content address.address1

      expect do
        ensure_delete_is_working
      end.to change(student.student_addresses, :count).by -1

      within(count_div) { page.should_not have_content 'Addresses list(1)' }
      within(tab_link)  { page.should_not have_content 'Addresses(1)' }
      page.should_not have_content address.address1
      flash_destroyed?
    end

    it "delete primary", :js => true do
      student_address2
      address1_tr = "#address-#{address.id}"
      address2_tr = "#address-#{address2.id}"

      visit gaku.student_path(student)


      click "#{address2_tr} a"
      accept_alert
      page.find("#{address2_tr} .primary_address a.btn-primary")

      click "#{address2_tr} .delete-link"
      accept_alert

      page.find("#{address1_tr} .primary_address a.btn-primary")

      student.student_addresses.first.is_primary? == true
    end

    it 'sets primary', :js => true do
      student_address2

      student.student_addresses.first.is_primary? == true
      student.student_addresses.second.is_primary? == false

      visit gaku.student_path(student)
      click tab_link

      within("#{table} tr#address-2") { click_link 'set_primary_link' }
      accept_alert

      student.student_addresses.first.is_primary? == false
      student.student_addresses.second.is_primary? == true
    end

  end
end
