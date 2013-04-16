require 'spec_helper'
require 'support/requests/contactable_spec'

describe 'Admin School Campus Contact' do

  as_admin

  let(:school) { create(:school) }
  let(:contact_type) { create(:contact_type, :name => 'Email') }

  before :all do
    set_resource "admin-school-campus-contact"
  end

  context 'new', :js => true do
    before do
      contact_type
      @data = school.campuses.first
      visit gaku.admin_school_campus_path(school, school.campuses.first)
    end

    it_behaves_like 'new contact'
  end

  context "existing", :js => true do
    context 'one contact' do

      before do
        @school = create(:school_with_one_contact)
        @school.reload
        @data = @school.campuses.first
      end

      context 'edit' do
        before do
          contact_type
          visit gaku.admin_school_campus_path(@school, @school.campuses.first)
        end

        it_behaves_like 'edit contact'

        it_behaves_like 'delete contact', @data

      end
    end

    context 'two contacts' do

      before do
        @school = create(:school_with_two_contacts)
        @school.reload
        @data = @school.campuses.first
        visit gaku.admin_school_campus_path(@school, @school.campuses.first)
      end

      it_behaves_like 'primary contacts'

    end


  end
end
