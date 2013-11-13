require 'spec_helper'

describe 'Student Contacts' do

  before { as :admin }

  let(:student) { create(:student) }
  let(:student_with_contact) { create(:student, :with_contact) }
  let(:student_with_contacts) { create(:student, :with_contacts) }
  let!(:contact_type) { create(:contact_type, name: 'Email') }

  before(:all) { set_resource 'student-contact' }

  context 'new', js: true, type: 'contact' do

    before do
      @resource = student
      visit gaku.edit_student_path(@resource)
      click tab_link
      wait_until { has_content? 'Contacts list' }
    end

    it_behaves_like 'new contact'
  end


  context 'existing', type: 'contact' do

    context 'one contact' do

      before { @resource = student_with_contact }

      context 'edit', js: true do

        before do
          visit gaku.edit_student_path(@resource)
          click tab_link
          wait_until { has_content? 'Contacts list' }
        end

        it_behaves_like 'edit contact'
        it_behaves_like 'delete contact', @resource
      end

    end

    context 'two contacts', type: 'contact' do

      before do
        @resource = student_with_contacts
        visit gaku.edit_student_path(@resource)
        click tab_link
        wait_until { has_content? 'Contacts list' }
      end

      it_behaves_like 'primary contacts'
    end
  end

end
