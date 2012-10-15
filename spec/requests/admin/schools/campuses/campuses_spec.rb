require 'spec_helper'

describe 'Campuses' do
  stub_authorization!

  before do 
    @school = create(:school, :name => 'Nagoya University')
    visit admin_school_campuses_path(@school)
  end

  context 'create and show' do
    it 'should create and show school campus' do 
      @school.campuses.count.should eq 1
      click_link 'new-admin-school-campus-link'

      fill_in 'campus_name', :with => 'Nagoya Campus'
      click_button 'submit-admin-school-campus-button'

      page.should have_content('Nagoya Campus')
      @school.campuses.count.should eq 2
    end 

    pending 'should cancel creating school campus', :js => true do 
    	@school.campuses.count.should eq 1
      click_link 'new-admin-school-campus-link'

      click_link 'back-admin-school-campus-link'

      @school.campuses.count.should eq 1
      current_path.should eq admin_school_campuses_path(@school)
    end
  end

  context 'index, edit and delete' do 

  	it 'should edit school campus', :js => true do
  	  within('table#admin-school-campuses-index tbody') { find('.edit-link').click }
  	  
  	  wait_until { find('#edit-campus-modal').visible? } 
  	  fill_in 'campus_name', :with => 'Nagoya Campus'
  	  click_button 'submit-admin-school-campus-button' 

  	  wait_until { !page.find('#edit-campus-modal').visible? }
  	  page.should have_content('Nagoya Campus')
  	  page.should_not have_content('Nagoya University')
  	  @school.campuses.count.should eq 1
  	end

  	it 'should delete school', :js => true do
      @school.campuses.count.should eq 1 
      tr_count = page.all('table#admin-school-campuses-index tr').size

      find('.delete-link').click 
      page.driver.browser.switch_to.alert.accept
        
      wait_until { page.all('table#admin-school-campuses-index tr').size == tr_count - 1 }
      @school.campuses.count.should eq 0
    end
  end

end