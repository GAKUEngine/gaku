require 'spec_helper'
require 'support/requests/contactable_spec'

describe 'Teacher Contacts' do

  as_admin

  let(:teacher) { create(:teacher) }
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
        @teacher = create(:teacher_with_one_contact)
        @teacher.reload
        @data = @teacher
      end

      context 'edit', :js => true do

        before do
          visit gaku.teacher_path(@teacher)
        end

        it_behaves_like 'edit contact'

        it_behaves_like 'delete contact', @data #the test uses @student

      end

    end

    context 'two contacts' do

      before do
        @teacher = create(:teacher_with_two_contacts)
        @teacher.reload
        @data = @teacher
        visit gaku.teacher_path(@teacher)
      end

      it_behaves_like 'primary contacts'

    end
  end
end
