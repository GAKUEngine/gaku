require 'spec_helper'
require 'support/requests/contactable_spec'

describe 'Admin Student Guardian Contacts' do

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
      visit gaku.edit_admin_student_path(student)
      @data = guardian
      click tab_link
      wait_until { page.has_content? 'Guardians list' }
      click show_link
    end

    it_behaves_like 'new contact'

  end

  context 'existing', js:true do

    context 'one contact' do

      before do
        @guardian = create(:guardian_with_one_contact)
        @guardian.reload
        student.guardians << @guardian
        @data = @guardian
        visit gaku.admin_student_guardian_path(student, @guardian)
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
        visit gaku.admin_student_guardian_path(student, @guardian)
      end

      it_behaves_like 'primary contacts'
    end

  end
end
