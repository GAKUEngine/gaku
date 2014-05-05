require 'spec_helper'

describe 'Student Contacts' do

  before { as :admin }

  let(:student) { create(:student) }
  let(:student_with_contact) { create(:student, :with_contact) }
  let(:student_with_contacts) { create(:student, :with_contacts) }
  let!(:contact_type) { create(:contact_type, name: 'Email') }

  before(:all) { set_resource 'student-contact' }

  context 'existing', type: 'contact' do

    context 'one contact' do

      before { @resource = student_with_contact }

      context 'edit', js: true do

        before do
          visit gaku.edit_student_path(@resource)
          click '#student-contacts-menu a'
          within('.contacts-count') { expect(page.has_content?('1')).to eq true }
          page.has_content? 'Contacts list'
        end

        it_behaves_like 'delete contact', @resource
      end

    end

  end

end
