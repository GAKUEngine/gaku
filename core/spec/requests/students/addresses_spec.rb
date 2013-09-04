require 'spec_helper'
require 'support/requests/addressable_spec'

describe 'Student Address' do

  before { as :admin }

  let(:student) { create(:student) }
  let(:student_with_address) { create(:student, :with_address) }
  let(:student_with_addresses) { create(:student, :with_addresses) }

  let(:country) { create(:country, name: 'Japan', iso: 'JP') }
  let(:country2) { create(:country, name: 'USA', iso: 'US') }
  let(:state) { create(:state, country: country) }

  before :all do
    set_resource 'student-address'
  end


  context 'new', js: true, type: 'address' do

    before do
      country
      visit gaku.edit_student_path(student)
    end

    it_behaves_like 'new address'

  end

  context 'state dropdown', js: true do

    before do
      country; country2; state
      visit gaku.edit_student_path(student_with_address)
    end

    context 'new form' do
      before { click new_link }

      it_behaves_like 'dynamic state dropdown'

    end

    context 'edit form' do
      before { click edit_link }

      it_behaves_like 'dynamic state dropdown'

    end

  end

  context 'existing', type: 'address' do

    context 'one address' do
      before(:each) do
        @data = student_with_address
        visit gaku.edit_student_path(@data)
        click tab_link
        wait_until { page.has_content? 'Addresses list' }
      end

      it_behaves_like 'edit address'

      context 'delete' do

        before do
          within(tab_link)  { page.should have_content 'Addresses(1)' }
        end

        it_behaves_like 'delete address'

        after do
          within(tab_link)  { page.should_not have_content 'Addresses(1)' }
        end

      end
    end

    context 'two addresses' do

      before(:each) do
        @data = student_with_addresses
        visit gaku.edit_student_path(@data)
        click tab_link
        wait_until { page.has_content? 'Addresses list' }
      end

      it_behaves_like 'primary addresses'

    end
  end
end
