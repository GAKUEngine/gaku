require 'spec_helper'

describe 'Student Guardian Contacts' do

  before { as :admin }
  before(:all) { set_resource 'student-guardian-contact' }

  let(:student) { create(:student) }
  let(:guardian) { create(:guardian) }
  let(:guardian_with_contact) { create(:guardian, :with_contact) }
  let(:guardian_with_contacts) { create(:guardian, :with_contacts) }
  let(:contact_type) { create(:contact_type, name: 'Email') }

  tab_link = '#student-guardian-contacts-tab-link'

  context 'new', js: true, type: 'contact'  do
    before(:each) do
      contact_type
      student.guardians << guardian
      visit gaku.edit_student_path(student)
      @resource = guardian
      click '#student-guardians-tab-link'
      wait_until { page.has_content? 'Guardians list' }
      click edit_link
      click tab_link
    end

    it_behaves_like 'new contact'

  end

  context 'existing', js: true, type: 'contact' do

    context 'one contact' do
      before do
        @resource = guardian_with_contact
        student.guardians << @resource
        visit gaku.edit_student_guardian_path(student, @resource)
        click tab_link
      end

      it_behaves_like 'edit contact'
      it_behaves_like 'delete contact', @resource
    end

    context 'two contacts', type: 'contact' do

      before do
        @resource = guardian_with_contacts
        student.guardians << @resource
        visit gaku.edit_student_guardian_path(student, @resource)
        click tab_link
      end

      it_behaves_like 'primary contacts'
    end

  end
end
