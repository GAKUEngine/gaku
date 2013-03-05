require 'spec_helper'
require 'support/requests/addressable_spec'

describe 'Admin School Campuses Address' do

  as_admin

  let(:address) { create(:address) }
  let(:school) { create(:school)}

  before :all do
    set_resource "admin-school-campus-address"
  end

  context 'new' do
    before do
      address
      visit gaku.admin_school_campus_path(school, school.master_campus)
    end

    it_behaves_like 'new address'
  end

  context "existing" do

    before do
      school.master_campus.address = address
      visit gaku.admin_school_campus_path(school, school.master_campus)
    end

    it_behaves_like 'edit address'

    it_behaves_like 'delete address'

  end
end
