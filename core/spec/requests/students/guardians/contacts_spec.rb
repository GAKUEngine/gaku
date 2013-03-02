require 'spec_helper'
require 'support/requests/contactable_spec'

describe 'Student Guardian Contacts' do

  as_admin

  let(:student) { create(:student) }
  let(:guardian) { create(:guardian) }
  let(:contact_type) { create(:contact_type, :name => 'Email') }

  tab_link = "#student-guardians-tab-link"

  before :all do
    set_resource "student-guardian-contact"
  end


  context 'new', :js => true  do
    before(:each) do
      contact_type
      student.guardians << guardian
      visit gaku.edit_student_path(student)
      @data = guardian
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
          select 'Email',           :from => 'contact_contact_type_id'
          fill_in 'contact_data',    :with => '777'

          click submit
          wait_until_invisible modal
        end.to change(guardian.contacts, :count).by 1

        click show_link
        page.should have_content 'Email'
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
      end

      it_behaves_like 'new contact'
    end
  end

  context 'existing', js:true do

    context 'one contact' do

      before do
        @guardian = create(:guardian_with_one_contact)
        @guardian.reload
        student.guardians << @guardian
        @data = @guardian
        visit gaku.student_guardian_path(student, @guardian)
      end


      it_behaves_like 'edit contact'

      it_behaves_like 'delete contact', @data

    end

    context 'two contacts' do

      before do
        @guardian = create(:guardian_with_two_contacts)
        @guardian.reload
        student.guardians << @guardian
        @data = @guardian
        visit gaku.student_guardian_path(student, @guardian)
      end

      it_behaves_like 'primary contacts'
    end

  end
end
