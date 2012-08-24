require 'spec_helper'

describe 'Guardian Contacts' do

  before(:each) do
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Students" }

    @student = Factory(:student)
    @guardian = Factory(:guardian)
    @student.guardians << @guardian
    @student.reload
    @contact_type = Factory(:contact_type, :name => 'mobile')

    visit student_path(@student) 
    click_link 'new_student_guardian_tab_link'
    wait_until { page.has_content?('Guardians List') } 
  end

  it "should add and show contact to a student guardian", :js => true do 
    click_link "add_student_guardian_contact_link" 
    wait_until { find('#newGuardianContactModal').visible? } 

    select 'mobile', :from => 'contact_contact_type_id'
    fill_in 'contact_data',    :with => '777'

    click_button 'submit_button'
    wait_until { !page.find('#newGuardianContactModal').visible? }

    click_link 'show_link'
    page.should have_content 'mobile'
    page.should have_content '777'
    @student.guardians.first.contacts.count.should == 1
  end

  context 'edit, delete and set primary' do 

    before do 
      mobile1 = Factory(:contact, :data => 123, :contact_type => @contact_type)
      mobile2 = Factory(:contact, :data => 321, :contact_type => @contact_type)
      @student.guardians.first.contacts << [ mobile1, mobile2 ]
      @student.reload
    end

    it 'should edit contact for student guardian', :js => true do 
      click_link 'show_link'
      page.should have_content '321'

      within('table.guardian_contact_table tr#contact_2') { click_link 'edit_link' }
      wait_until { find('#editContactModal').visible? } 

      fill_in 'contact_data', :with => '777'
      click_button 'submit_button'
      
      page.should have_content '777'
      page.should_not have_content '321'
    end

    it 'should delete a contact for student guardian' do
      click_link 'show_link'
      page.should have_content '321'

      within('table.guardian_contact_table tr#contact_2') { click_link 'delete_link' }
      @student.guardians.first.contacts.size.should == 1
      page.should_not have_content '321'
    end

    it 'should make a primary contact to student guardian', :js => true do 
      click_link 'show_link'

      @student.guardians.first.contacts.first.is_primary? == true
      @student.guardians.first.contacts.second.is_primary? == false

      within('table.guardian_contact_table tr#contact_2') { click_link 'set_primary_link' } 
      page.driver.browser.switch_to.alert.accept

      @student.guardians.first.contacts.first.is_primary? == false
      @student.guardians.first.contacts.second.is_primary? == true

      #TODO Check the css classes of primary button
    end

  end
end