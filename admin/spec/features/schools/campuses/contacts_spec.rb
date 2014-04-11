require 'spec_helper'

describe 'Admin School Campus Contact' do

  before { as :admin }
  before(:all) { set_resource 'admin-school-campus-contact' }


  let!(:contact_type) { create(:contact_type, name: 'Email') }

  context 'new', js: true, type: 'contact' do
    let(:school) { create(:school) }

    before do
      @resource = school.campuses.first
      visit gaku.edit_admin_school_campus_path(school, @resource)
      click '#contacts-menu a'
    end

    it_behaves_like 'new contact'
  end

  context 'existing', js: true, type: 'contact' do
    let(:school) { create(:school_with_one_contact) }

    context 'one contact' do
      before do
        school.reload
        @resource = school.campuses.first
      end

      context 'edit' do
        before do
          visit gaku.edit_admin_school_campus_path(school, @resource)
          click '#contacts-menu a'
        end

        it_behaves_like 'edit contact'
        it_behaves_like 'delete contact', @resource
      end
    end

    context 'two contacts', type: 'contact' do
      let(:school) { create(:school_with_two_contacts) }

      before do
        school.reload
        @resource = school.campuses.first
        visit gaku.edit_admin_school_campus_path(school, @resource)
        click '#contacts-menu a'
      end

      it_behaves_like 'primary contacts'
    end
  end

end
