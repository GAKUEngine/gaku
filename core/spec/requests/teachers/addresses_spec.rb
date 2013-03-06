require 'spec_helper'
require 'support/requests/addressable_spec'

describe 'Teacher Address' do

  as_admin

  let(:teacher) { create(:teacher) }
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
        @teacher =  create(:teacher_with_one_address)
        @teacher.reload
        visit gaku.teacher_path(@teacher)
        wait_until { page.has_content? 'Addresses list' }
        @data = @teacher
      end

      it_behaves_like 'edit address'
      
      it_behaves_like 'delete address'
      
    end

    context 'two addresses' do

      before(:each) do
        @teacher =  create(:teacher_with_two_addresses)
        @teacher.reload
        visit gaku.teacher_path(@teacher)
        wait_until { page.has_content? 'Addresses list' }
        @data = @teacher
      end

      it_behaves_like 'primary addresses'
    end
  end
end
