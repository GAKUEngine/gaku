require 'spec_helper'

describe 'Contact' do
  
  before do
    @student = Factory(:student)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Students" }
  end

  it "should add and show student contact", :js => true do
    Factory(:contact_type, :name => 'email')
    visit student_path(@student) 

    click_link 'new_student_contact_tab_link'
    click_link 'new_student_contact_link'

    wait_until { page.has_content?('New Contact') } 

    select 'email', :from => 'contact_contact_type_id'
    fill_in "contact_data", :with => "The contact data"
    fill_in "contact_details", :with => "The contact details"
    click_button "Save Contact"

    page.should have_selector('a', href: "/students/1/contacts/1/edit")
    page.should have_content("The contact data")
    page.should have_content("The contact details")
    @student.contacts.size.should == 1
  end

  context "edit and delete" do 

    before(:each) do 
      @contact_type = Factory(:contact_type, :name => 'email')
      @contact = Factory(:contact, :contact_type => @contact_type)
      @student.contacts << @contact

      visit student_path(@student) 
      click_link 'new_student_contact_tab_link'
      wait_until { page.has_content?('Contacts list') } 
    end

    it "should edit a student contact", :js => true do 
      click_link "edit_link" 
      wait_until { find('#editContactModal').visible? } 

      fill_in 'contact_data',    :with => 'example@genshin.org'
      click_button 'submit_button'

      wait_until { !page.find('#editContactModal').visible? }

      page.should have_content('example@genshin.org')
    end

    it "should delete a student contact", :js => true do
      #page.all('table.index tr').size.should == 2
      page.should have_content(@contact.data)
      @student.contacts.size.should == 1

      click_link 'delete_link' 
      page.driver.browser.switch_to.alert.accept
      #FIXME Make a real check, no sleep 
      sleep 1
      #page.all('table.index tr').size.should == 2
      @student.guardians.size.should == 0
      page.should_not have_content(@contact.data)
    end
  end
end