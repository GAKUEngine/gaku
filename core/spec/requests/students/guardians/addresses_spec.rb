require 'spec_helper'
require 'support/requests/addressable_spec'


describe 'Student Guardian Addresses' do

  as_admin

  let(:student)  { create(:student) }
  let(:guardian) { create(:guardian) }
  let(:guardian_with_address) { create(:guardian, :with_address) }
  let(:guardian_with_addresses) { create(:guardian, :with_addresses) }
  let(:country)  { create(:country, :name => "Japan") }
  let(:bulgaria) { create(:country, :name => "Bulgaria") }

  before :all do
    set_resource "student-guardian-address"
  end

  context 'new', :js => true do
    before do
      country
      student.guardians << guardian
      visit gaku.edit_student_guardian_path(student, guardian)
    end

    it_behaves_like 'new address'
  end

  context 'existing' do

    context 'one address' do
      before do
        bulgaria
        @data = guardian_with_address
        student.guardians << @data
        visit gaku.edit_student_guardian_path(student, @data)
      end

      it_behaves_like 'edit address'

      context 'delete' do

        it_behaves_like 'delete address'

      end
    end

    context 'two addresses' do
      before do
        bulgaria
        @data = guardian_with_addresses
        student.guardians << @data
        visit gaku.edit_student_guardian_path(student, @data)
      end

      it_behaves_like 'primary addresses'
    end
  end

end
