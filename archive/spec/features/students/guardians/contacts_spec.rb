require 'spec_helper'

describe 'Student Guardian Contacts' do

  before(:all) { set_resource 'guardian-contact' }
  before { as :admin }

  let(:student) { create(:student) }
  let(:guardian) { create(:guardian) }
  let(:guardian_with_contact) { create(:guardian, :with_contact) }
  let(:guardian_with_contacts) { create(:guardian, :with_contacts) }
  let(:contact_type) { create(:contact_type, name: 'Email') }

  context 'existing', js: true, type: 'contact' do

    context 'one contact' do
      before do
        @resource = guardian_with_contact
        student.guardians << @resource
        visit gaku.edit_student_guardian_path(student, @resource)
        click '#guardian-contacts-menu a'
      end

      it_behaves_like 'delete contact', @resource
    end

  end
end
