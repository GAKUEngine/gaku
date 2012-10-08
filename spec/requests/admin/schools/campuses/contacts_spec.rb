require 'spec_helper'

describe 'Contact' do
  stub_authorization!

  before do
    @school = create(:school)
    @contact_type = create(:contact_type, :name => 'email')
  end

  context 'new' do 
    before do 
      visit admin_school_campus_path(@school, @school.campuses.first) 
      click_link 'new-admin-school-campus-contact-link'
    end

    it "should add and show campus contact", :js => true do
      tr_count = page.all('table#admin-school-campus-contacts-index tr').size
      @school.campuses.first.contacts.size.should eq 0
      
      wait_until { find('#new-admin-school-campus-contact').visible? } 

      select 'email', :from => 'contact_contact_type_id'
      fill_in "contact_data", :with => "The contact data"
      fill_in "contact_details", :with => "The contact details"
      click_button "submit-admin-school-campus-contact-button"
      
      wait_until { !page.find('#new-admin-school-campus-contact').visible? }
      page.should have_content("The contact data")
      page.should have_content("The contact details")
      page.all('table#admin-school-campus-contacts-index tr').size == tr_count + 1
      within('.admin-school-campus-contacts-count') { page.should have_content('Contacts list(1)') }
      @school.reload
      @school.campuses.first.contacts.size.should eq 1
    end

    it 'should cancel adding contact', :js => true do
      click_link 'cancel-admin-school-campus-contact-link'
      wait_until { !page.find('#new-admin-school-campus-contact').visible? }
    end
  end


  context "edit, delete, set primary" do 
    before(:each) do 
      @contact = create(:contact, :contact_type => @contact_type)
      @school.campuses.first.contacts << @contact 
    end

    it "should edit a campus contact", :js => true do 
      visit admin_school_campus_path(@school, @school.campuses.first)
      wait_until { page.has_content?('Contacts list') } 
      find(".edit-link").click 
      wait_until { find('#edit-contact-modal').visible? } 

      fill_in 'contact_data', :with => 'example@genshin.org'
      click_button 'submit-admin-school-campus-contact-button'

      wait_until { !page.find('#edit-contact-modal').visible? }
      page.should have_content('example@genshin.org')
    end

    it 'should cancel editting', :js => true do 
      visit admin_school_campus_path(@school, @school.campuses.first)

      find(".edit-link").click 

      click_link 'cancel-admin-school-campus-contact-link'
      wait_until { !page.find('#edit-contact-modal').visible? }
    end


    it "should set contact as primary", :js => true do 
      contact2 = create(:contact, :data => 'gaku2@example.com', :contact_type => @contact_type)

      @school.campuses.first.contacts << contact2
      
      visit admin_school_campus_path(@school, @school.campuses.first)
      wait_until { page.has_content?('Contacts list') } 
   
      @school.campuses.first.contacts.first.is_primary? == true
      @school.campuses.first.contacts.second.is_primary? == false

      within('table#admin-school-campus-contacts-index tr#contact-2') { click_link 'set-primary-link' }
      page.driver.browser.switch_to.alert.accept

      @school.campuses.first.contacts.first.is_primary? == false
      @school.campuses.first.contacts.second.is_primary? == true
    end

    it "should delete a student contact", :js => true do
      visit admin_school_campus_path(@school, @school.campuses.first)

      tr_count = page.all('table#admin-school-campus-contacts-index tr').size
      within('.admin-school-campus-contacts-count') { page.should have_content('Contacts list(1)') }
      page.should have_content(@contact.data)
      @school.campuses.first.contacts.size.should eq 1

      find('.delete-link').click 
      page.driver.browser.switch_to.alert.accept
      
      wait_until { page.all('table#admin-school-campus-contacts-index tr').size == tr_count - 1 }
      within('.admin-school-campus-contacts-count') { page.should_not have_content('Contacts list(1)') }
      @school.campuses.first.contacts.size.should eq 0
      page.should_not have_content(@contact.data)
    end
  end
end
