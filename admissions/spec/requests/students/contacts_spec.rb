require 'spec_helper'
require 'support/requests/contactable_spec'

describe 'Admin Student Contacts' do

  as_admin

  let(:student) { create(:student) }
  let(:contact_type) { create(:contact_type, :name => 'Email') }

  before :all do
    set_resource "student-contact"
  end

  context 'new', :js => true do

    before do
      contact_type
      @data = student
      visit gaku.edit_admin_student_path(id:student.id)
      click tab_link
    end

    it_behaves_like 'new contact'

  end


  context "existing" do

    context 'one contact' do

      before(:each) do
        @student = create(:student, :with_contact)
        @student.reload
        @data = @student
      end

      context 'edit', :js => true do

        before do
          visit gaku.edit_admin_student_path(@student)
          click tab_link
        end

        it_behaves_like 'edit contact'

        it_behaves_like 'delete contact', @data #the test uses @student

      end

    end

    context 'two contacts' do

      before do
        @student = create(:student, :with_contacts)
        @student.reload
        @data = @student
        visit gaku.edit_admin_student_path(@student)
        click tab_link
      end

      it_behaves_like 'primary contacts'

    end
  end
end
