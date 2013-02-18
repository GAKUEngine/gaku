require 'spec_helper'

describe 'Student Contacts' do

  as_admin

  let(:student) { create(:student) }
  let(:contact_type) { create(:contact_type, :name => 'email') }

  before :all do
    set_resource "student-contact"
  end

  context 'new', :js => true do
    before do
      contact_type
      visit gaku.student_path(student)
      click new_link
      wait_until_visible submit
    end

    it "adds and shows" do
      expect do
        select 'email',            :from => 'contact_contact_type_id'
        fill_in "contact_data",    :with => "The contact data"
        fill_in "contact_details", :with => "The contact details"
        click submit
        wait_until_invisible form
      end.to change(student.contacts, :count).by 1

      page.should have_content "The contact data"
      page.should have_content "The contact details"
      within(count_div) { page.should have_content 'Contacts list(1)' }
      flash_created?
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end


  context "existing" do

    context 'one contact' do
      before(:each) do
        @student = create(:student_with_one_contact)
        @student.reload
      end

      context 'edit', :js => true do
        before do
          visit gaku.student_path(@student)
          within(table) { click edit_link }
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

        it "deletes", :js => true do
          contact_field = @student.contacts.first.data
          visit gaku.student_path(@student)

          within(count_div) { page.should have_content 'Contacts list(1)' }
          page.should have_content contact_field

          expect do
            ensure_delete_is_working
          end.to change(@student.contacts, :count).by -1

          within(count_div) { page.should_not have_content 'Contacts list(1)' }
          page.should_not have_content contact_field
          flash_destroyed?
        end
      end

    end

    context 'two contacts' do

      before do
        @student = create(:student_with_two_contacts)
        @student.reload
        visit gaku.student_path(@student)
      end

      it "sets primary", :js => true do

        @student.contacts.first.primary? == true
        @student.contacts.second.primary? == false

        within("#{table} tr#contact-2") { click_link 'set-primary-link' }
        accept_alert

        @student.contacts.first.primary? == false
        @student.contacts.second.primary? == true
      end

      it "delete primary", :js => true do
        contact1_tr = "#contact-#{@student.contacts.first.id}"
        contact2_tr = "#contact-#{@student.contacts.second.id}"

        within("#{table} #{contact2_tr}") { click_link 'set-primary-link' }
        accept_alert

        !page.find("#{contact2_tr} td.primary-contact a.btn-primary")

        click "#{contact2_tr} .delete-link"
        accept_alert

        page.find("#{contact1_tr} .primary-contact a.btn-primary")
        @student.contacts.first.primary? == true
      end

    end
  end
end
