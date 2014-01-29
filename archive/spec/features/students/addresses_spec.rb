require 'spec_helper'

describe 'Student Address' do

  let(:student) { create(:student) }
  let(:student_with_address) { create(:student, :with_address) }
  let(:student_with_addresses) { create(:student, :with_addresses) }

  let!(:country) { create(:country, name: 'Japan', iso: 'JP') }

  before(:all) { set_resource 'student-address' }
  before { as :admin }

  context 'existing', type: 'address' do

    context 'one address' do
      before(:each) do
        @resource = student_with_address
        visit gaku.edit_student_path(@resource)
        click tab_link
        has_content? 'Addresses list'
      end

      it_behaves_like 'delete address'
    end

  end

end
