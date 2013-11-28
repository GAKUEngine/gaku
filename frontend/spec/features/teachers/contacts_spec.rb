require 'spec_helper'

describe 'Teacher Contacts' do

  before { as :admin }
  before(:all) { set_resource 'teacher-contact' }

  let(:teacher) { create(:teacher) }
  let(:teacher_with_contact) { create(:teacher, :with_contact) }
  let(:teacher_with_contacts) { create(:teacher, :with_contacts) }
  let!(:contact_type) { create(:contact_type, name: 'Email') }

  context 'new', js: true, type: 'contact' do

    before do
      @resource = teacher
      visit gaku.edit_teacher_path(@resource)
      click tab_link

    end

    it_behaves_like 'new contact'
  end

  context 'existing', type: 'contact' do

    context 'one contact' do

      before { @resource = teacher_with_contact }

      context 'edit', js: true do

        before do
          visit gaku.edit_teacher_path(@resource)
          click tab_link
        end

        it_behaves_like 'edit contact'
        it_behaves_like 'delete contact', @resource
      end

    end

    context 'two contacts', type: 'contact' do

      before do
        @resource = teacher_with_contacts
        visit gaku.edit_teacher_path(@resource)
        click tab_link
      end

      it_behaves_like 'primary contacts'
    end
  end

end
