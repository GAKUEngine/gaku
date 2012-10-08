require 'spec_helper'

describe 'Schools' do
  stub_authorization!

  context 'create and show' do
  	before do 
  	  visit admin_schools_path
    end

    it 'should create and show school', :js => true do 
      School.count.should eq 0
      click_link 'new-admin-school-link'

      wait_until { page.find('#new-admin-school').visible? }
      !page.find('#new-admin-school-link').visible?
      fill_in 'school_name', :with => 'Nagoya University'
      click_button 'submit-admin-school-button'

      wait_until { !page.find('#new-admin-school').visible? }
      page.find('#new-admin-school-link').visible?
      page.should have_content('Nagoya University')
      School.count.should eq 1
    end 

    it 'should cancel creating school', :js => true do 
    	School.count.should eq 0
      click_link 'new-admin-school-link'

      wait_until { page.find('#new-admin-school').visible? }
      click_link 'cancel-admin-school-link'

      wait_until { !page.find('#new-admin-school').visible? }
      School.count.should eq 0
    end
  end

  context 'index, edit and delete' do 
    before do
      @school = create(:school, :name => 'Varna Technical University') 
      visit admin_schools_path
    end

  	it 'should edit school', :js => true do
  	  within('table#admin-schools-index tbody') { find('.edit-link').click }
  	  
  	  wait_until { find('#edit-admin-school-modal').visible? } 
  	  fill_in 'school_name', :with => 'Sofia Technical University'
  	  click_button 'submit-admin-school-button' 

  	  wait_until { !page.find('#edit-admin-school-modal').visible? }
  	  page.should have_content('Sofia Technical University')
  	  page.should_not have_content('Varna Technical University')
  	  School.count.should eq 1
  	end

  	it 'should delete school', :js => true do
      School.count.should eq 1 
      tr_count = page.all('table#admin-schools-index tr').size

      find('.delete-link').click 
      page.driver.browser.switch_to.alert.accept
        
      wait_until { page.all('table#admin-schools-index tr').size == tr_count - 1 }
      School.count.should eq 0
    end
  end

end