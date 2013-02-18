require 'spec_helper'

describe 'Admin School Campus Contact' do

  as_admin

  let(:school) { create(:school) }
  let(:contact_type) { create(:contact_type, :name => 'email') }

  before :all do
    set_resource "admin-school-campus-contact"
  end

  context 'new', :js => true do
    before do
      contact_type
      visit gaku.admin_school_campus_path(school, school.campuses.first)
      click new_link
      wait_until_visible submit
    end

    it "creates and shows" do
      expect do
        select 'email', :from => 'contact_contact_type_id'
        fill_in "contact_data", :with => "The contact data"
        fill_in "contact_details", :with => "The contact details"
        click submit
        wait_until_invisible form
      end.to change(school.campuses.first.contacts, :count).by 1

      page.should have_content "The contact data"
      page.should have_content "The contact details"
      within(count_div) { page.should have_content 'Contacts list(1)' }
      flash_created?
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context "existing", :js => true do
    context 'one contact' do

      before do
        @school = create(:school_with_one_contact)
        @school.reload
      end

      context 'edit' do
        before do
          contact_type
          visit gaku.admin_school_campus_path(@school, @school.campuses.first)
          click edit_link
          wait_until_visible modal
        end

        it "edits" do
          fill_in 'contact_data', :with => 'example@genshin.org'
          click submit

          wait_until_invisible modal
          page.should have_content 'example@genshin.org'
          flash_updated?
        end

        it 'cancels editting', :cancel => true do
          ensure_cancel_modal_is_working
        end

        it "deletes" do
          contact_field = @school.campuses.first.contacts.first.data
          visit gaku.admin_school_campus_path(@school, @school.campuses.first)

          within(count_div) { page.should have_content 'Contacts list(1)' }
          page.should have_content contact_field

          expect do
            ensure_delete_is_working
          end.to change(@school.campuses.first.contacts, :count).by -1

          page.should_not have_content contact_field
          within(count_div) { page.should_not have_content 'Contacts list(1)' }
          flash_destroyed?
        end
      end
    end

    context 'two contacts' do

      before do
        @school = create(:school_with_two_contacts)
        @school.reload
      end

      it "sets as primary" do
        visit gaku.admin_school_campus_path(@school, @school.campuses.first)

        @school.campuses.first.contacts.first.primary? == true
        @school.campuses.first.contacts.second.primary? == false

        within('table#admin-school-campus-contacts-index tr#contact-2') { click_link 'set-primary-link' }
        accept_alert

        @school.campuses.first.contacts.first.primary? == false
        @school.campuses.first.contacts.second.primary? == true
      end
    end


  end
end
