require 'spec_helper'
require 'support/requests/addressable_spec'

describe 'Student Address' do

  as_admin

  let(:student) { create(:student) }
  let(:country) { create(:country, :name => "Japan") }

  before :all do
    set_resource "student-address"
  end

  context 'new', :js => true do
    
    before do
      country
      visit gaku.student_path(student)

      it_behaves_like 'new address'

      it { has_validations? }
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

        

        it 'errors without required fields' do
          fill_in 'address_address1',  :with => ''
          fill_in 'address_city',      :with => ''

          has_validations?
        end

        it_behaves_like 'edit address'

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

        click tab_link

        within("#{table} #{address2_tr}") { click_link 'set_primary_link' }
        accept_alert

        page.find("#{address2_tr} .primary_address a.btn-primary")

        within("#{table} #{address2_tr}") { click '.delete-link'}
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
        within("#{table} tr#address-#{@student.addresses.second.id}") { click_link 'set_primary_link' }
        accept_alert

        @student.addresses.first.primary? == false
        @student.addresses.second.primary? == true
      end
    end
  end
end
