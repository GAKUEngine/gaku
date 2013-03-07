require 'spec_helper'
require 'support/requests/addressable_spec'


describe 'Student Guardian Addresses' do

  as_admin

  let(:student)  { create(:student) }
  let(:guardian) { create(:guardian) }
  let(:country)  { create(:country, :name => "Japan") }
  let(:bulgaria) { create(:country, :name => "Bulgaria") }

  tab_link = "#student-guardians-tab-link"

  before :all do
    set_resource "student-guardian-address"
  end

  context 'new', :js => true do
    before do
      country
      student.guardians << guardian
      visit gaku.edit_student_path(student)
      click tab_link
      wait_until { page.has_content? 'Guardians list' }
      click show_link
    end

    it_behaves_like 'new address'
  end

  context 'existing' do

    context 'one address' do
      before do
        bulgaria
        @guardian = create(:guardian_with_one_address)
        @guardian.reload
        student.guardians << @guardian
        visit gaku.student_guardian_path(student, @guardian)
      end

      it_behaves_like 'edit address'

      context 'delete' do
        
        before do
          @data = @guardian
        end

        it_behaves_like 'delete address'

      end
    end

    context 'two addresses' do
      before do
        bulgaria
        @guardian = create(:guardian_with_two_addresses)
        @guardian.reload
        student.guardians << @guardian
        visit gaku.student_guardian_path(student, @guardian)
        @data = @guardian
      end

      it_behaves_like 'primary addresses'
    end
  end

end
