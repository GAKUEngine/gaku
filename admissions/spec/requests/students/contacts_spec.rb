require 'spec_helper'
require 'support/requests/contactable_spec'

describe 'Admin Student Contacts' do

  as_admin

  let(:student) { create(:student) }
  let(:contact_type) { create(:contact_type, :name => 'email') }

  before :all do
    set_resource "student-contact"
  end

  context 'new', :js => true do
    
    before do
      contact_type
      visit gaku.admin_student_path(id:student.id)
    end

    it_should_behave_like 'new contact'
    
  end


  context "existing" do

    context 'one contact' do

      before(:each) do
        @student = create(:student_with_one_contact)
        @student.reload
      end

      context 'edit', :js => true do
        
        before do
          visit gaku.admin_student_path(@student)
        end

        it_should_behave_like 'edit contact'

        it_should_behave_like 'delete contact', @student #the test uses @student
        
      end

    end

    context 'two contacts' do

      before do
        @student = create(:student_with_two_contacts)
        @student.reload
        visit gaku.admin_student_path(@student)
      end

      it_should_behave_like 'primary contacts'

    end
  end
end
