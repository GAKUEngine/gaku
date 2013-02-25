require 'spec_helper'
require 'support/requests/addressable_spec'

describe 'Admin Student Address' do

  as_admin

  let(:student) { create(:student) }
  let(:country) { create(:country, :name => "Japan") }

  before :all do
    set_resource "student-address"
  end

  context 'new', :js => true do
    
    before do
      country
      visit gaku.admin_student_path(student)
    end

    it_behaves_like 'new address'

  end

  context 'existing' do

    context 'one address' do
      before(:each) do
        @student =  create(:student_with_one_address)
        @student.reload
        visit gaku.admin_student_path(@student)
        click tab_link
        wait_until { page.has_content? 'Addresses list' }
      end

      it_behaves_like 'edit address'

      context 'delete' do
        
        before do
          @data = @student
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
        @student = create(:student_with_two_addresses)
        @student.reload
        @data = @student
        visit gaku.admin_student_path(@student)
        click tab_link
        wait_until { page.has_content? 'Addresses list' }
      end

      it_behaves_like 'primary addresses'

    end
  end
end
