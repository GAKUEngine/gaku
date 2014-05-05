require 'spec_helper'

describe 'Student Guardian Addresses' do

  before(:all) { set_resource 'guardian-address' }
  before { as :admin }

  let(:student)  { create(:student) }
  let(:guardian) { create(:guardian) }
  let(:guardian_with_address) { create(:guardian, :with_address) }
  let(:guardian_with_addresses) { create(:guardian, :with_addresses) }

  let!(:country) { create(:country, name: 'Japan', iso: 'JP') }

  context 'existing', type: 'address' do

    context 'one address' do
      before(:each) do
        @resource = guardian_with_address
        student.guardians << @resource
        visit gaku.edit_student_guardian_path(student, @resource)
        click '#guardian-addresses-menu a'
        page.has_content? 'Addresses list'
      end

      it_behaves_like 'delete address'
    end

  end

end
