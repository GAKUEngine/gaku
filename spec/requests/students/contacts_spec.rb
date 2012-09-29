require 'spec_helper'

describe 'Contact' do
  stub_authorization!

  before do
    @student = Factory(:student)
    @contact_type = Factory(:contact_type, :name => 'email')
  end

  context 'new' do 
    before do 
      visit student_path(@student) 
      click_link 'new-student-contact-link'
    end

    it "should add and show student contact", :js => true do
      tr_count = page.all('table#student-contacts-index tr').size
      @student.contacts.size.should eql(0)
      
      wait_until { find('#new-student-contact-form').visible? } 

      select 'email', :from => 'contact_contact_type_id'
      fill_in "contact_data", :with => "The contact data"
      fill_in "contact_details", :with => "The contact details"
      click_button "submit-student-contact-button"
      
      wait_until { !page.find('#new-student-contact-form').visible? }
      page.should have_selector('a', href: "/students/1/contacts/1/edit")
      page.should have_content("The contact data")
      page.should have_content("The contact details")
      page.all('table#student-contacts-index tr').size == tr_count + 1
      within('.student-contacts-count') { page.should have_content('Contacts list(1)') }
      @student.reload
      @student.contacts.size.should eql(1)
    end

    it 'should cancel adding contact', :js => true do
      click_link 'cancel-student-contact-link'
      wait_until { !page.find('#new-student-contact-form').visible? }
    end
  end


  context "edit, delete, set primary" do 
    before(:each) do 
      @contact = Factory(:contact, :contact_type => @contact_type)
      @student.contacts << @contact 
    end

    it "should edit a student contact", :js => true do 
      visit student_path(@student)
      wait_until { page.has_content?('Contacts list') } 
      find(".edit-link").click 
      wait_until { find('#edit-contact-modal').visible? } 

      fill_in 'contact_data', :with => 'example@genshin.org'
      click_button 'submit-student-contact-button'

      wait_until { !page.find('#edit-contact-modal').visible? }
      page.should have_content('example@genshin.org')
    end

    it 'should cancel editting', :js => true do 
      visit student_path(@student)
      find(".edit-link").click 

      click_link 'cancel-student-contact-link'
      wait_until { !page.find('#edit-contact-modal').visible? }
    end


    it "should set contact as primary", :js => true do 
      contact2 = Factory(:contact, :data => 'gaku2@example.com', :contact_type => @contact_type)
      @student.contacts << contact2
      
      visit student_path(@student) 
      wait_until { page.has_content?('Contacts list') } 
     
      within('table#student-contacts-index tr#contact-1 td.primary-contact') { page.should have_content('Primary')}
      within('table#student-contacts-index tr#contact-2 td.primary-contact') { page.should_not have_content('Primary')}

      @student.contacts.first.is_primary? == true
      @student.contacts.second.is_primary? == false

      within('table#student-contacts-index tr#contact-2') { click_link 'set-primary-link' }
      page.driver.browser.switch_to.alert.accept

      within('table#student-contacts-index tr#contact-1 td.primary-contact') { page.should_not have_content('Primary')}
      within('table#student-contacts-index tr#contact-2 td.primary-contact') { page.should have_content('Primary')}
      @student.contacts.first.is_primary? == false
      @student.contacts.second.is_primary? == true
    end

    it "should delete a student contact", :js => true do
      visit student_path(@student)
      wait_until { page.has_content?('Contacts list') } 
      
      tr_count = page.all('table#student-contacts-index tr').size
      page.should have_content(@contact.data)
      @student.contacts.size.should eql(1)

      find('.delete-link').click 
      page.driver.browser.switch_to.alert.accept
      
      wait_until { page.all('table#student-contacts-index tr').size == tr_count - 1 }
      within('.student-contacts-count') { page.should_not have_content('Contacts list(1)') }
      @student.contacts.size.should eql(0)
      page.should_not have_content(@contact.data)
    end
  end
end
