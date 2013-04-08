require 'spec_helper'
require 'support/requests/contactable_spec'

describe 'Student Contacts' do

  as_admin

  let(:student) { create(:student) }
  let(:student_with_contact) { create(:student, :with_contact) }
  let(:student_with_contacts) { create(:student, :with_contacts) }
  let!(:contact_type) { create(:contact_type, :name => 'Email') }

  before :all do
    set_resource "student-contact"
  end

  context 'new', :js => true do

    before do
      @data = student
      visit gaku.edit_student_path(@data)
      click tab_link
      wait_until { page.has_content? 'Contacts list' }
    end

    it_behaves_like 'new contact'

  end


  context "existing" do

    context 'one contact' do

      before(:each) do
        @data = student_with_contact
      end

      context 'edit', :js => true do

        before do
          visit gaku.edit_student_path(@data)
          click tab_link
          wait_until { page.has_content? 'Contacts list' }
        end

        it_behaves_like 'edit contact'

        it_behaves_like 'delete contact', @data

      end

    end

    context 'two contacts' do

      before do
        @data = student_with_contacts
        visit gaku.edit_student_path(@data)
        click tab_link
        wait_until { page.has_content? 'Contacts list' }
      end

      it_behaves_like 'primary contacts'

    end
  end
end
