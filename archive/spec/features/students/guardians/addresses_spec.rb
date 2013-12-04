require 'spec_helper'

describe 'Student Guardian Addresses' do

  before(:all) { set_resource 'student-guardian-address' }
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
        click tab_link
        page.has_content? 'Addresses list'
      end

      it_behaves_like 'delete address'
    end

    context 'two addresses' do

      before(:each) do
        @resource = guardian_with_addresses
        student.guardians << @resource
        visit gaku.edit_student_guardian_path(student, @resource)
        click tab_link
        page.has_content? 'Addresses list'
      end

      it_behaves_like 'primary addresses'
    end
  end

end
