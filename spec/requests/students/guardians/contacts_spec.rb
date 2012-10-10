require 'spec_helper'

describe 'Guardian Contacts' do
  stub_authorization!

  before(:each) do
    @student = create(:student)
    @guardian = create(:guardian)
    @student.guardians << @guardian
    @student.reload
    @contact_type = create(:contact_type, :name => 'mobile')

    visit student_path(@student) 
    click_link 'new-student-guardian-tab-link'
    wait_until { page.has_content?('Guardians list') } 
  end

  context 'new' do 
    context 'thru modal' do 
      it "should add and show contact to a student guardian thru modal", :js => true do 
        @student.guardians.first.contacts.count.should eql(0)
        tr_count = page.all('table#student-guardian-contacts-index tr').size
        click_link "new-student-guardian-contact-link"

        wait_until { find('#new-contact-modal').visible? } 
        select 'mobile', :from => 'contact_contact_type_id'
        fill_in 'contact_data',    :with => '777'

        click_button 'submit-student-guardian-contact-button'
        wait_until { !page.find('#new-contact-modal').visible? }

        find('.show-link').click
        page.should have_content 'mobile'
        page.should have_content '777'
        @student.guardians.first.contacts.count.should eql(1)
      end

      it 'should cancel adding thru modal', :js => true do 
        click_link "new-student-guardian-contact-link"
        wait_until { find('#new-contact-modal').visible? }

        click_link 'cancel-student-guardian-contact-link'
        wait_until { !page.find('#new-contact-modal').visible? }
      end
    end
    
    context 'thru slide form' do 
      it "should add and show contact to a student guardian thru slide form", :js => true do 
        find('.show-link').click
        @student.guardians.first.contacts.count.should eql(0)
        tr_count = page.all('table#student-guardian-contacts-index tr').size

        click_link "new-student-guardian-contact-link"

        wait_until { find('#new-student-guardian-contact form').visible? } 
        select 'mobile', :from => 'contact_contact_type_id'
        fill_in 'contact_data',    :with => '777'

        click_button 'submit-student-guardian-contact-button'

        wait_until { !page.find('#new-student-guardian-contact form').visible? }
        page.should have_content 'mobile'
        page.should have_content '777'
        page.all('table#student-guardian-contacts-index tr').size == tr_count + 1
        within('.student-guardian-contacts-count') { page.should have_content('Contacts list(1)') }
        @student.guardians.first.contacts.count.should eql(1)
      end

      it 'should cancel adding thru slide form', :js => true do 
        find('.show-link').click
        click_link "new-student-guardian-contact-link"
        wait_until { find('#new-student-guardian-contact form').visible? }
        !page.find('#new-student-guardian-contact-link').visible?

        click_link 'cancel-student-guardian-contact-link'
        wait_until { !page.find('#new-student-guardian-contact form').visible? }
        find('#new-student-guardian-contact-link').visible?

        click_link "new-student-guardian-contact-link"
        wait_until { find('#new-student-guardian-contact form').visible? }
        !page.find('#new-student-guardian-contact-link').visible?
      end
    end
  end

  context 'edit, delete and set primary' do 

    before do 
      mobile1 = create(:contact, :data => 123, :contact_type => @contact_type)
      mobile2 = create(:contact, :data => 321, :contact_type => @contact_type)
      @student.guardians.first.contacts << [ mobile1, mobile2 ]
      @student.reload
      find('.show-link').click
    end

    it 'should edit contact for student guardian', :js => true do 
      page.should have_content '321'

      within('table#student-guardian-contacts-index tr#contact-2') { find('.edit-link').click }
      wait_until { find('#edit-contact-modal').visible? } 

      fill_in 'contact_data', :with => '777'
      click_button 'submit-student-guardian-contact-button'
      wait_until { !page.find('#edit-contact-modal').visible? }
      page.should have_content '777'
      page.should_not have_content '321'
    end

    it 'should cancel editting', :js => true do 
      within('table#student-guardian-contacts-index tr#contact-2') { find('.edit-link').click }
      wait_until { find('#edit-contact-modal').visible? } 

      click_link 'cancel-student-guardian-contact-link'
      wait_until { !page.find('#edit-contact-modal').visible? }
    end

    it 'should delete a contact for student guardian', :js => true  do
      page.should have_content '321'
      within('.student-guardian-contacts-count') { page.should have_content('Contacts list(2)') }
      @student.guardians.first.contacts.size.should eql(2)
      tr_count = page.all('#student-guardian-contacts-index tr').size
      
      find('.delete-link').click
      page.driver.browser.switch_to.alert.accept

      wait_until { page.all('#student-guardian-contacts-index tr').size == tr_count - 1 } 
      within('.student-guardian-contacts-count') { page.should_not have_content('Contacts list(2)') }
      @student.guardians.first.contacts.size.should eql(1)
      #page.should_not have_content '321'
    end

    it 'should make a primary contact to student guardian', :js => true do 
      @student.guardians.first.contacts.first.is_primary? == true
      @student.guardians.first.contacts.second.is_primary? == false

      within("table#student-guardian-contacts-index tr#contact-#{@student.guardians.first.contacts.second.id}") do
        click_link 'set-primary-link' 
      end 
      page.driver.browser.switch_to.alert.accept

      @student.guardians.first.contacts.first.is_primary? == false
      @student.guardians.first.contacts.second.is_primary? == true

      #TODO Check the css classes of primary button
    end

  end
end