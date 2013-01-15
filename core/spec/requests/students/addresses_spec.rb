require 'spec_helper'

describe 'Address' do
  stub_authorization!

  let(:student) { create(:student) }
  let(:country) { create(:country, :name => "Japan") }

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
        wait_until_invisible submit
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

    it { has_validations? }

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do

    context 'one address' do
      before(:each) do
        @student =  create(:student_with_one_address)
        @student.reload
        visit gaku.student_path(@student)
        click tab_link
        wait_until { page.has_content? 'Addresses list' }
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
          wait_until_invisible submit

          page.should have_content 'Edited street address'
          page.should have_content 'Tokyo'
          page.should have_content 'Edited address'
          flash_updated?
        end

        it 'errors without required fields' do
          fill_in 'address_address1',  :with => ''
          fill_in 'address_city',      :with => ''

          has_validations?
        end

        it 'cancels editting', :cancel => true do
          ensure_cancel_modal_is_working
        end
      end

      it 'deletes', :js => true do
        address_field = @student.addresses.first.address1

        within(tab_link)  { page.should have_content 'Addresses(1)' }
        within(count_div) { page.should have_content 'Addresses list(1)' }
        page.should have_content address_field

        expect do
          ensure_delete_is_working
        end.to change(@student.addresses, :count).by -1

        within(count_div) { page.should_not have_content 'Addresses list(1)' }
        within(tab_link)  { page.should_not have_content 'Addresses(1)' }
        page.should_not have_content address_field
        flash_destroyed?
      end
    end

    context 'two addresses' do

      before(:each) do
        @student =  create(:student_with_two_addresses)
        @student.reload
        visit gaku.student_path(@student)
        click tab_link
        wait_until { page.has_content? 'Addresses list' }

      end

      it "delete primary", :js => true do

        address1_tr = "#address-#{@student.addresses.first.id}"
        address2_tr = "#address-#{@student.addresses.second.id}"

        visit gaku.student_path(@student)

        click "#{address2_tr} a"
        accept_alert
        page.find("#{address2_tr} .primary_address a.btn-primary")

        click "#{address2_tr} .delete-link"
        accept_alert

        page.find("#{address1_tr} .primary_address a.btn-primary")

        @student.addresses.first.primary? == true
      end

      it 'sets primary', :js => true do
        @student.addresses.first.primary? == true
        @student.addresses.second.primary? == false

        visit gaku.student_path(@student)
        click tab_link

        #sleep 10

        within("#{table} tr#address-2") { click_link 'set_primary_link' }
        accept_alert

        @student.addresses.first.primary? == false
        @student.addresses.second.primary? == true
      end
    end
  end
end
