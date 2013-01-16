require 'spec_helper'

describe 'Student Guardian Contacts' do

  stub_authorization!

  let(:student) { create(:student) }
  let(:guardian) { create(:guardian) }
  let(:contact_type) { create(:contact_type, :name => 'mobile') }

  tab_link = "#student-guardians-tab-link"

  before :all do
    set_resource "student-guardian-contact"
  end


  context 'new', :js => true  do
    before(:each) do
      contact_type
      student.guardians << guardian
      visit gaku.student_path(student)

      click tab_link
      wait_until { page.has_content? 'Guardians list' }
    end

    context 'thru modal' do
      before do
        click new_link
        wait_until_visible modal
      end

      it "creates and shows" do
        expect do
          select 'mobile',           :from => 'contact_contact_type_id'
          fill_in 'contact_data',    :with => '777'

          click submit
          wait_until_invisible modal
        end.to change(guardian.contacts, :count).by 1

        click show_link
        page.should have_content 'mobile'
        page.should have_content '777'
        within(count_div) { page.should have_content 'Contacts list(1)' }
      end

      it 'cancels creating', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end

    context 'thru slide form' do
      before do
        click show_link
        click new_link
        wait_until_visible submit
      end

      it "creates and shows" do
        expect do
          select 'mobile', :from => 'contact_contact_type_id'
          fill_in 'contact_data',    :with => '777'

          click submit
         wait_until_invisible form
        end.to change(guardian.contacts, :count).by 1

        page.should have_content 'mobile'
        page.should have_content '777'
        within(count_div) { page.should have_content 'Contacts list(1)' }
        flash_created?
      end

      it 'cancels creating', :cancel => true do
        ensure_cancel_creating_is_working
      end
    end
  end

  context 'existing' do

    context 'one contact' do

      before do
        @guardian = create(:guardian_with_one_contact)
        @guardian.reload
        student.guardians << @guardian
        visit gaku.student_guardian_path(student, @guardian)
      end

      context 'edit', :js => true do

        before do
          page.should have_content @guardian.contacts.first.data
          within(table) { click edit_link }
          wait_until_visible modal
        end

        it 'edits' do
          contact_field = @guardian.contacts.first.data

          fill_in 'contact_data', :with => '777'
          click submit

          wait_until_invisible modal
          page.should have_content '777'
          page.find(table).should_not contact_field
          flash_updated?
        end

        it 'cancels editting', :cancel => true do
          ensure_cancel_modal_is_working
        end
      end

      it 'deletes', :js => true  do
        contact_field = @guardian.contacts.first.data
        page.should have_content contact_field
        within(count_div) { page.should have_content 'Contacts list(1)' }

        expect do
          ensure_delete_is_working
        end.to change(@guardian.contacts, :count).by -1

        within(count_div) { page.should_not have_content 'Contacts list(1)' }
        page.find(table).should_not have_content contact_field
        flash_destroyed?
      end
    end

    context 'two contacts' do

      before do
        @guardian = create(:guardian_with_two_contacts)
        @guardian.reload
        student.guardians << @guardian
        visit gaku.student_guardian_path(student, @guardian)
      end

      it "delete primary", :js => true do
        contact1_tr = "#contact-#{@guardian.contacts.first.id}"
        contact2_tr = "#contact-#{@guardian.contacts.second.id}"

        click "#{contact2_tr} td.primary-button a"
        accept_alert

        page.find("#{contact2_tr} td.primary-button a.btn-primary")

        click "#{contact2_tr} .delete-link"
        accept_alert

        page.find("#{contact1_tr} td.primary-button a.btn-primary")

        @guardian.contacts.first.primary? == true
      end

      it 'sets primary', :js => true do
        @guardian.contacts.first.primary? == true
        @guardian.contacts.second.primary? == false

        within("#{table} tr#contact-#{@guardian.contacts.second.id}") do
          click_link 'set-primary-link'
        end
        accept_alert

        @guardian.contacts.first.primary? == false
        @guardian.contacts.second.primary? == true
      end
    end

  end
end
