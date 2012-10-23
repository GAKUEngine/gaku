require 'spec_helper'

describe 'Student Guardian Addresses' do

  stub_authorization!

  tab_link = "#student-guardians-tab-link"

  before :all do
    Helpers::Request.resource("student-guardian-address")
  end

  before(:each) do
    @student = create(:student)
    @guardian = create(:guardian)
    @student.guardians << @guardian
    @student.reload
    @country = create(:country, :name => "Japan")

    visit student_path(@student) 
    click tab_link
    wait_until { page.has_content? 'Guardians list' } 
  end
  
  context 'new', :js => true do 
    before do 
      click show_link
      click new_link
      wait_until_visible submit
    end

    it "creates and shows" do 
      expect do 
        #required
        select 'Japan',              :from => 'country_dropdown'
        fill_in 'address_address1',  :with => 'Subaru str.'
        fill_in 'address_city',      :with => 'Nagoya'
        click submit
        wait_until_invisible form
      end.to change(@student.guardians.first.addresses, :count).by 1

      page.should have_content 'Japan'
      page.should have_content 'Nagoya'
      page.should have_content 'Subaru str.'

      within(count_div) { page.should have_content 'Addresses list(1)' }
      flash_created?
    end

    it 'cancels creating' do 
      ensure_cancel_creating_is_working
    end 
  end

  context 'existing' do 
    before do 
      address1 = create(:address, :address1 => 'Toyota str.', :country => @country, :city => 'Nagoya')
      @student.guardians.first.addresses <<  address1
      visit student_guardian_path(@student, @student.guardians.first)
    end

    context 'edit', :js => true do 
      before do 
        create(:country, :name => "Brasil")
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do 
        select 'Brasil',            :from => 'country_dropdown'
        fill_in 'address_address1', :with => 'Rio str.'
        fill_in 'address_city',     :with => 'Brasilia'

        click submit
        wait_until_invisible modal
        page.should have_content 'Brasil'
        within(table) { page.should_not have_content 'Japan' }
        flash_updated?
      end

      it 'cancels edit' do 
        ensure_cancel_modal_is_working
      end
  end

    it 'deletes', :js => true do 
      page.should have_content 'Japan'
      within(count_div) { page.should have_content 'Addresses list(1)' }
      
      expect do
        ensure_delete_is_working
      end.to change(@student.guardians.first.addresses, :count).by -1
      
      within(count_div) { page.should_not have_content 'Addresses list(1)' }
      page.should_not have_content 'Japan'
      flash_destroyed?
    end

    it 'sets primary', :js => true do 
      bulgaria = create(:country, :name => "Bulgaria")
      address2 = create(:address, :address1 => 'Maria Luiza bul.', :country => bulgaria, :city => 'Varna')
      @student.guardians.first.addresses <<  address2

      visit student_guardian_path(@student, @student.guardians.first)

      @student.guardians.first.guardian_addresses.first.is_primary? == true
      @student.guardians.first.guardian_addresses.second.is_primary? == false

      within('table#student-guardian-addresses-index tr#address-2') { click_link 'set_primary_link' }

      @student.guardians.first.guardian_addresses.first.is_primary? == false
      @student.guardians.first.guardian_addresses.second.is_primary? == true
    end
  end
  
end