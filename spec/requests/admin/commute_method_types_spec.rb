require 'spec_helper'

describe 'CommuteMethodTypes' do
  stub_authorization!

  context 'create and show' do
  	before do 
  	  visit admin_commute_method_types_path
    end

    it 'should create and show commute method type', :js => true do 
      tr_count = page.all('table#admin-commute-method-types-index tr').size
      CommuteMethodType.count.should eq 0
      click_link 'new-admin-commute-method-type-link'

      wait_until { page.find('#new-admin-commute-method-type form').visible? }
      !page.find('#new-admin-commute-method-type-link').visible?
      fill_in 'commute_method_type_name', :with => 'car'
      click_button 'submit-admin-commute-method-type-button'

      wait_until { !page.find('#new-admin-commute-method-type form').visible? }
      page.find('#new-admin-commute-method-type-link').visible?
      page.should have_content('car')
      page.all('table#admin-commute-method-types-index tr').size == tr_count + 1
      within('.admin-commute-method-types-count') { page.should have_content('Commute Method Types list(1)') }
      CommuteMethodType.count.should eq 1 
    end 

    it 'should cancel creating commute method type', :js => true do 
      click_link 'new-admin-commute-method-type-link'
      
      wait_until { page.find('#cancel-admin-commute-method-type-link').visible? }
      
      click_link 'cancel-admin-commute-method-type-link'

      wait_until { !page.find('#new-admin-commute-method-type').visible? }
      click_link 'new-admin-commute-method-type-link'
  
      wait_until { page.find('#new-admin-commute-method-type').visible? }
    end
  end

  context 'index, edit and delete' do 
    before do
      @commute_method_type = create(:commute_method_type, :name => 'metro') 
      visit admin_commute_method_types_path
    end

  	it 'should edit commute method type', :js => true do
  	  within('table#admin-commute-method-types-index tbody') { find('.edit-link').click }
  	  
  	  wait_until { find('#edit-commute-method-type-modal').visible? } 
  	  fill_in 'commute_method_type_name', :with => 'car'
  	  click_button 'submit-admin-commute-method-type-button' 

  	  wait_until { !page.find('#edit-commute-method-type-modal').visible? }
  	  page.should have_content('car')
  	  page.should_not have_content('metro')
  	  CommuteMethodType.count.should eq 1
  	end

    it 'should cancel editting', :js => true do 
      within('table#admin-commute-method-types-index tbody') { find('.edit-link').click }
      wait_until { find('#cancel-admin-commute-method-type-link').visible? }

      click_link 'cancel-admin-commute-method-type-link'
      wait_until { !page.find('#edit-commute-method-type-modal').visible? }
    end


  	it 'should delete commute method type', :js => true do
      CommuteMethodType.count.should eq 1
      within('.admin-commute-method-types-count') { page.should have_content('Commute Method Types list(1)') }
      tr_count = page.all('table#admin-commute-method-types-index tr').size

      find('.delete-link').click
      page.driver.browser.switch_to.alert.accept
        
      wait_until { page.all('table#admin-commute-method-types-index tr').size == tr_count - 1 }
      within('.admin-commute-method-types-count') { page.should_not have_content('Commute Method Types list(1)') }
      CommuteMethodType.count.should eq 0
    end
  end

end