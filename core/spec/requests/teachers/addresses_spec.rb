require 'spec_helper'

describe 'Teacher Address' do

  let(:teacher) { create(:teacher) }
  let(:teacher_with_address) { create(:teacher, :with_address) }
  let(:teacher_with_addresses) { create(:teacher, :with_addresses) }

  let!(:country) { create(:country, name: 'Japan', iso: 'JP') }

  before(:all) { set_resource 'teacher-address' }
  before { as :admin }

  context 'new', js: true, type: 'address' do
    before do
      @resource = teacher
      visit gaku.edit_teacher_path(@resource)
    end

    it_behaves_like 'new address'
  end

  context 'state dropdown', js: true, type: 'address' do

    before do
      @resource = teacher_with_address
      visit gaku.edit_teacher_path(@resource)
    end

    it_behaves_like 'dynamic state dropdown'
  end

  context 'existing', type: 'address' do

    context 'one address' do
      before(:each) do
        @resource = teacher_with_address
        visit gaku.edit_teacher_path(@resource)
        click tab_link
        wait_until { has_content? 'Addresses list' }
      end

      it_behaves_like 'edit address'
      it_behaves_like 'delete address'
    end

    context 'two addresses' do

      before(:each) do
        @resource = teacher_with_addresses
        visit gaku.edit_teacher_path(@resource)
        click tab_link
        wait_until { page.has_content? 'Addresses list' }
      end

      it_behaves_like 'primary addresses'
    end
  end

end
