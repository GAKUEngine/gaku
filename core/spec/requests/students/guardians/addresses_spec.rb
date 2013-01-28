require 'spec_helper'

describe 'Student Guardian Addresses' do

  stub_authorization!

  let(:student)  { create(:student) }
  let(:guardian) { create(:guardian) }
  let(:country)  { create(:country, :name => "Japan") }
  let(:bulgaria) { create(:country, :name => "Bulgaria") }

  tab_link = "#student-guardians-tab-link"

  before :all do
    set_resource "student-guardian-address"
  end

  context 'new', :js => true do
    before do
      country
      student.guardians << guardian
      visit gaku.student_path(student)
      click tab_link
      wait_until { page.has_content? 'Guardians list' }
      click show_link
      click new_link
      wait_until_visible submit
    end

    it "creates and shows" do
      expect do
        #required
        select 'Japan',              :from => 'country_dropdown'
        fill_in 'address_address1',  :with => 'Subaru str.'
        fill_in 'address_city',      :with => 'Nagoya'
        click submit
        wait_until_invisible form
      end.to change(guardian.addresses, :count).by 1

      page.should have_content 'Japan'
      page.should have_content 'Nagoya'
      page.should have_content 'Subaru str.'

      within(count_div) { page.should have_content 'Addresses list(1)' }
      flash_created?
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do

    context 'one address' do
      before do
        bulgaria
        @guardian = create(:guardian_with_one_address)
        @guardian.reload
        student.guardians << @guardian
        visit gaku.student_guardian_path(student, @guardian)
      end

      context 'edit', :js => true do
        before do
          within(table) { click edit_link }
          wait_until_visible modal
        end

        it 'edits' do
          select 'Bulgaria',          :from => 'country_dropdown'
          fill_in 'address_address1', :with => 'Maria Luiza bul.'
          fill_in 'address_city',     :with => 'Varna'

          click submit
          wait_until_invisible modal
          wait_until { page.should have_content 'Bulgaria' }
          within(table) { page.should_not have_content 'Japan' }
          flash_updated?
        end

        it 'cancels edit', :cancel => true do
          ensure_cancel_modal_is_working
        end
      end

      it 'deletes', :js => true do
        address_field = @guardian.addresses.first.address1

        page.should have_content address_field
        within(count_div) { page.should have_content 'Addresses list(1)' }

        expect do
          ensure_delete_is_working
        end.to change(@guardian.addresses, :count).by -1

        within(count_div) { page.should_not have_content 'Addresses list(1)' }
        page.find(table).should_not have_content address_field
        flash_destroyed?
      end
    end

    context 'two addresses' do
      before do
        bulgaria
        @guardian = create(:guardian_with_two_addresses)
        @guardian.reload
        student.guardians << @guardian
        visit gaku.student_guardian_path(student, @guardian)
      end

      it "delete primary", :js => true do
        address1_tr = "#address-#{@guardian.addresses.first.id}"
        address2_tr = "#address-#{@guardian.addresses.first.id}"
        visit gaku.student_guardian_path(student, @guardian)

        click "#{address2_tr} a"
        accept_alert


        page.find("#{address2_tr} .primary_address a.btn-primary")
        !page.find("#{address1_tr} .primary_address a.btn-primary")

        click "#{address2_tr} .delete-link"
        accept_alert

        page.find("#{address1_tr} .primary_address a.btn-primary")

        @guardian.addresses.first.primary? == true
      end

      it 'sets primary', :js => true do
        visit gaku.student_guardian_path(student, @guardian)

        @guardian.addresses.first.primary? == true
        @guardian.addresses.second.primary? == false

        within('table#student-guardian-addresses-index tr#address-2') { click_link 'set_primary_link' }
        accept_alert

        @guardian.addresses.first.primary? == false
        @guardian.addresses.second.primary? == true
      end
    end
  end

end
