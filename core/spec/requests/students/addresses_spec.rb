require 'spec_helper'

describe 'Student Address' do

  let(:student) { create(:student) }
  let(:student_with_address) { create(:student, :with_address) }
  let(:student_with_addresses) { create(:student, :with_addresses) }

  let!(:country) { create(:country, name: 'Japan', iso: 'JP') }

  before(:all) { set_resource 'student-address' }
  before { as :admin }

  context 'new', js: true, type: 'address' do
    before do
      @resource = student
      visit gaku.edit_student_path(@resource)
    end

    it_behaves_like 'new address'
  end

  context 'state dropdown', js: true, type: 'address' do

    before do
      @resource = student_with_address
      visit gaku.edit_student_path(@resource)
    end

    it_behaves_like 'dynamic state dropdown'
  end

  context 'existing', type: 'address' do

    context 'one address' do
      before(:each) do
        @resource = student_with_address
        visit gaku.edit_student_path(@resource)
        click tab_link
        wait_until { has_content? 'Addresses list' }
      end

      it_behaves_like 'edit address'
      it_behaves_like 'delete address'
    end

    context 'two addresses' do

      before(:each) do
        @resource = student_with_addresses
        visit gaku.edit_student_path(@resource)
        click tab_link
        wait_until { page.has_content? 'Addresses list' }
        sleep 5
      end

      it_behaves_like 'primary addresses'
    end
  end

end
