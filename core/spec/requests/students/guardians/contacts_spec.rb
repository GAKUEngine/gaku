require 'spec_helper'
require 'support/requests/contactable_spec'

describe 'Student Guardian Contacts' do

  as_admin

  let(:student) { create(:student) }
  let(:guardian) { create(:guardian) }
  let(:guardian_with_contact) { create(:guardian, :with_contact) }
  let(:guardian_with_contacts) { create(:guardian, :with_contacts) }
  let(:contact_type) { create(:contact_type, :name => 'Email') }

  tab_link = "#student-guardian-contacts-tab-link"

  before :all do
    set_resource "student-guardian-contact"
  end


  context 'new', :js => true  do
    before(:each) do
      contact_type
      student.guardians << guardian
      visit gaku.edit_student_path(student)
      @data = guardian
      click "#student-guardians-tab-link"
      wait_until { page.has_content? 'Guardians list' }
      click edit_link
      click tab_link
    end

    it_behaves_like 'new contact'

  end

  context 'existing', js:true do

    context 'one contact' do

      before do
        @data = guardian_with_contact
        student.guardians << @data
        visit gaku.edit_student_guardian_path(student, @data)
        click tab_link
      end


      it_behaves_like 'edit contact'

      it_behaves_like 'delete contact', @data

    end

    context 'two contacts' do

      before do
        @data = guardian_with_contacts
        student.guardians << @data
        visit gaku.edit_student_guardian_path(student, @data)
        click tab_link
      end

      it_behaves_like 'primary contacts'
    end

  end
end
