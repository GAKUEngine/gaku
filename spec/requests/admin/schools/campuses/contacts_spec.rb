require 'spec_helper'

describe 'Contact' do

  form           = '#new-admin-school-campus-contact'
  new_link       = '#new-admin-school-campus-contact-link'
  modal          = '#edit-contact-modal'

  submit_button  = '#submit-admin-school-campus-contact-button'
  cancel_link    = '#cancel-admin-school-campus-contact-link'
  
  table          = '#admin-school-campus-contacts-index'
  table_rows     = '#admin-school-campus-contacts-index tr'
  count_div      = '.admin-school-campus-contacts-count'

  stub_authorization!

  before do
    @school = create(:school)
    @contact_type = create(:contact_type, :name => 'email')
  end

  context 'new', :js => true do 
    before do 
      visit admin_school_campus_path(@school, @school.campuses.first) 
      click new_link
      wait_until_visible submit_button
    end

    it "creates and shows contact" do
      @school.campuses.first.contacts.size.should eq 0
      
      select 'email', :from => 'contact_contact_type_id'
      fill_in "contact_data", :with => "The contact data"
      fill_in "contact_details", :with => "The contact details"
      click submit_button
      
      wait_until_invisible form
      page.should have_content("The contact data")
      page.should have_content("The contact details")
      within(count_div) { page.should have_content('Contacts list(1)') }
      @school.reload
      @school.campuses.first.contacts.size.should eq 1
    end

    it 'cancels creating' do
      click cancel_link
      wait_until_invisible form

      click new_link
      wait_until_visible submit_button
    end
  end

  context "existing", :js => true do 
    before(:each) do 
      @contact = create(:contact, :contact_type => @contact_type)
      @school.campuses.first.contacts << @contact 
    end

    context 'edit' do 
      before do 
        visit admin_school_campus_path(@school, @school.campuses.first)
        click edit_link
        wait_until_visible modal
      end

      it "edits contact" do 
        fill_in 'contact_data', :with => 'example@genshin.org'
        click submit_button

        wait_until_invisible modal
        page.should have_content('example@genshin.org')
      end

      it 'cancels editting' do 
        click cancel_link
        wait_until_invisible modal
      end
    end

    it "sets contact as primary" do 
      contact2 = create(:contact, :data => 'gaku2@example.com', :contact_type => @contact_type)

      @school.campuses.first.contacts << contact2
      
      visit admin_school_campus_path(@school, @school.campuses.first)

      @school.campuses.first.contacts.first.is_primary? == true
      @school.campuses.first.contacts.second.is_primary? == false

      within('table#admin-school-campus-contacts-index tr#contact-2') { click_link 'set-primary-link' }
      accept_alert

      @school.campuses.first.contacts.first.is_primary? == false
      @school.campuses.first.contacts.second.is_primary? == true
    end

    it "deletes contact" do
      visit admin_school_campus_path(@school, @school.campuses.first)

      within(count_div) { page.should have_content('Contacts list(1)') }
      page.should have_content(@contact.data)
      @school.campuses.first.contacts.size.should eq 1

      ensure_delete_is_working(delete_link, table_rows)

      within(count_div) { page.should_not have_content('Contacts list(1)') }
      @school.campuses.first.contacts.size.should eq 0
      page.should_not have_content(@contact.data)
    end
  end
end
