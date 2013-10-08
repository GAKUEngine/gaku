require 'spec_helper'

describe 'Teacher Contacts' do

  before { as :admin }

  let(:teacher) { create(:teacher) }
  let(:teacher_with_contact) { create(:teacher, :with_contact) }
  let(:teacher_with_contacts) { create(:teacher, :with_contacts) }
  let(:contact_type) { create(:contact_type, name: 'Email') }

  before :all do
    set_resource 'teacher-contact'
  end

  context 'new', js: true, type: 'contact' do

    before do
      contact_type
      visit gaku.edit_teacher_path(teacher)
      click tab_link
      @data = teacher
    end

    it_behaves_like 'new contact'

  end

  context 'existing', type: 'contact' do

    context 'one contact' do

      before(:each) do
        @data = teacher_with_contact
      end

      context 'edit', js: true do

        before do
          visit gaku.edit_teacher_path(@data)
          click tab_link
        end

        it_behaves_like 'edit contact'

        it_behaves_like 'delete contact', @data

      end

    end

    context 'two contacts', type: 'contact' do

      before do
        @data = teacher_with_contacts
        visit gaku.edit_teacher_path(@data)
        click tab_link
      end

      it_behaves_like 'primary contacts'

    end
  end
end
