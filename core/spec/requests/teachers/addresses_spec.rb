require 'spec_helper'
require 'support/requests/addressable_spec'

describe 'Teacher Address' do

  as_admin

  let(:teacher) { create(:teacher) }
  let(:teacher_with_address) { create(:teacher, :with_address) }
  let(:teacher_with_addresses) { create(:teacher, :with_addresses) }
  let(:country) { create(:country, :name => "Japan") }

  before :all do
    set_resource "teacher-address"
  end

  context 'new', :js => true do

    before do
      country
      visit gaku.teacher_path(teacher)
    end

    it_behaves_like 'new address'

  end

  context 'existing' do

    context 'one address' do

      before(:each) do
        @data = teacher_with_address
        visit gaku.teacher_path(@data)
        wait_until { page.has_content? 'Addresses list' }
      end

      it_behaves_like 'edit address'

      it_behaves_like 'delete address'

    end

    context 'two addresses' do

      before(:each) do
        @data = teacher_with_addresses
        visit gaku.teacher_path(@data)
        wait_until { page.has_content? 'Addresses list' }
      end

      it_behaves_like 'primary addresses'
    end
  end
end
