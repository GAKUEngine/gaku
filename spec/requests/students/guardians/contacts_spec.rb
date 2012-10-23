require 'spec_helper'

describe 'Student Guardian Contacts' do

  stub_authorization!

  tab_link = "#student-guardians-tab-link"

  before :all do
    Helpers::Request.resource("student-guardian-contact") 
  end

  before(:each) do
    @student = create(:student)
    @guardian = create(:guardian)
    @student.guardians << @guardian
    @student.reload
    @contact_type = create(:contact_type, :name => 'mobile')

    visit student_path(@student) 
    click tab_link
    wait_until { page.has_content? 'Guardians list' } 
  end

  context 'new', :js => true  do 

    context 'thru modal' do 
      before do 
        click new_link
        wait_until_visible modal
      end

      it "creates and shows" do  
        expect do 
          select 'mobile',           :from => 'contact_contact_type_id'
          fill_in 'contact_data',    :with => '777'

          click submit
          wait_until_invisible modal
        end.to change(@student.guardians.first.contacts, :count).by 1

        click show_link
        page.should have_content 'mobile'
        page.should have_content '777'
        within(count_div) { page.should have_content 'Contacts list(1)' }
      end

      it 'cancels creating thru modal' do 
        ensure_cancel_modal_is_working
      end
    end
    
    context 'thru slide form' do 
      before do 
        click show_link
        click new_link
        wait_until_visible submit
      end

      it "creates and shows" do 
        expect do 
          select 'mobile', :from => 'contact_contact_type_id'
          fill_in 'contact_data',    :with => '777'

          click submit
         wait_until_invisible form
        end.to change(@student.guardians.first.contacts, :count).by 1

        page.should have_content 'mobile'
        page.should have_content '777'
        within(count_div) { page.should have_content 'Contacts list(1)' }
        flash_created?
      end

      it 'cancels creating' do 
        ensure_cancel_creating_is_working
      end
    end
  end

  context 'existing' do 
    before do 
      mobile1 = create(:contact, :data => 123, :contact_type => @contact_type)
      @student.guardians.first.contacts << mobile1
      @student.reload
    end
    
    context 'edit', :js => true do 
      before do 
        click show_link
        page.should have_content '123'
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do 
        fill_in 'contact_data', :with => '777'
        click submit

        wait_until_invisible modal
        page.should have_content '777'
        page.should_not have_content '123'
        flash_updated?
      end

      it 'cancels editting' do 
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes', :js => true  do
      click show_link
      page.should have_content '123'
      within(count_div) { page.should have_content 'Contacts list(1)' }

      expect do
        ensure_delete_is_working 
      end.to change(@student.guardians.first.contacts, :count).by -1

      within(count_div) { page.should_not have_content 'Contacts list(1)' }
      page.should_not have_content '123'
      flash_destroyed?
    end

    it 'sets primary', :js => true do 
      mobile2 = create(:contact, :data => 321, :contact_type => @contact_type)
      @student.guardians.first.contacts << mobile2
      click show_link

      @student.guardians.first.contacts.first.is_primary? == true
      @student.guardians.first.contacts.second.is_primary? == false

      within("#{table} tr#contact-#{@student.guardians.first.contacts.second.id}") do
        click_link 'set-primary-link' 
      end 
      accept_alert

      @student.guardians.first.contacts.first.is_primary? == false
      @student.guardians.first.contacts.second.is_primary? == true
    end

  end
end