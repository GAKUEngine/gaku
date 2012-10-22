require 'spec_helper'

describe 'EnrollmentStatusTypes' do
  stub_authorization!

  context 'create and show' do
  	before do 
  	  visit admin_enrollment_status_types_path
    end

    it 'should create and show enrollment status type', :js => true do 
      tr_count = page.all('table#admin-enrollment-status-types-index tr').size
      EnrollmentStatusType.count.should eq 0
      click_link 'new-admin-enrollment-status-type-link'

      wait_until { page.find('#new-admin-enrollment-status-type form').visible? }
      !page.find('#new-admin-enrollment-status-type-link').visible?
      fill_in 'enrollment_status_type_name', :with => 'Enrolled'
      click_button 'submit-admin-enrollment-status-type-button'

      wait_until { !page.find('#new-admin-enrollment-status-type form').visible? }
      page.find('#new-admin-enrollment-status-type-link').visible?
      page.should have_content('Enrolled')
      page.all('table#admin-enrollment-status-types-index tr').size == tr_count + 1
      within('.admin-enrollment-status-types-count') { page.should have_content('Enrollment Status Types list(1)') }
      EnrollmentStatusType.count.should eq 1 
    end 

    it 'should cancel creating enrollment status type', :js => true do 
      click_link 'new-admin-enrollment-status-type-link'

      wait_until { page.find('#cancel-admin-enrollment-status-type-link').visible? }
      click_link 'cancel-admin-enrollment-status-type-link'

      wait_until { !page.find('#new-admin-enrollment-status-type form').visible? }
      click_link 'new-admin-enrollment-status-type-link'
  
      wait_until { page.find('#new-admin-enrollment-status-type form').visible? }
    end
  end

  context 'index, edit and delete' do 
    before do
      @enrollment_status_type = create(:enrollment_status_type, :name => 'Admitted') 
      visit admin_enrollment_status_types_path
    end

  	it 'should edit enrollment status type', :js => true do
  	  within('table#admin-enrollment-status-types-index tbody') { find('.edit-link').click }
  	  
  	  wait_until { find('#edit-enrollment-status-type-modal').visible? } 
  	  fill_in 'enrollment_status_type_name', :with => 'Expelled'
  	  click_button 'submit-admin-enrollment-status-type-button' 

  	  wait_until { !page.find('#edit-enrollment-status-type-modal').visible? }
  	  page.should have_content('Expelled')
  	  page.should_not have_content('Admitted')
  	  EnrollmentStatusType.count.should eq 1
  	end

    it 'should cancel editting', :js => true do 
      within('table#admin-enrollment-status-types-index tbody') { find('.edit-link').click }
      wait_until { find('#edit-enrollment-status-type-modal').visible? }

      click_link 'cancel-admin-enrollment-status-type-link'
      wait_until { !page.find('#edit-enrollment-status-type-modal').visible? }
    end


  	it 'should delete enrollment status type', :js => true do
      EnrollmentStatusType.count.should eq 1
      within('.admin-enrollment-status-types-count') { page.should have_content('Enrollment Status Types list(1)') }
      tr_count = page.all('table#admin-enrollment-status-types-index tr').size

      find('.delete-link').click
      page.driver.browser.switch_to.alert.accept
        
      wait_until { page.all('table#admin-enrollment-status-types-index tr').size == tr_count - 1 }
      within('.admin-enrollment-status-types-count') { page.should_not have_content('Enrollment Status Types list(1)') }
      EnrollmentStatusType.count.should eq 0
    end
  end

end