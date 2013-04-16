require 'spec_helper'
require 'support/requests/contactable_spec'

describe 'Teacher Contacts' do

  as_admin

  let(:teacher) { create(:teacher) }
  let(:teacher_with_contact) { create(:teacher, :with_contact) }
  let(:teacher_with_contacts) { create(:teacher, :with_contacts) }
  let(:contact_type) { create(:contact_type, :name => 'Email') }

  before :all do
    set_resource "teacher-contact"
  end

  context 'new', :js => true do

    before do
      contact_type
      visit gaku.teacher_path(teacher)
      @data = teacher
    end

    it_behaves_like 'new contact'

  end

  context "existing" do

    context 'one contact' do

      before(:each) do
        @data = teacher_with_contact
      end

      context 'edit', :js => true do

        before do
          visit gaku.teacher_path(@data)
        end

        it_behaves_like 'edit contact'

        it_behaves_like 'delete contact', @data

      end

    end

    context 'two contacts' do

      before do
        @data = teacher_with_contacts
        visit gaku.teacher_path(@data)
      end

      it_behaves_like 'primary contacts'

    end
  end
end
