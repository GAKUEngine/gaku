require 'spec_helper'

describe 'ClassGroups' do
  before do
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Class Management" }
    within('ul#menu') { click_link "Class Listing" }
  end

  it 'should create and show class group', :js => true do
    click_link 'new_class_group_link'
    fill_in 'class_group_grade', :with => '7'
    fill_in 'class_group_name', :with => 'Awesome class group'
    fill_in 'class_group_homeroom', :with => 'room#7'

    click_button 'submit_button'

    page.should have_content '7'
    page.should have_content 'Awesome class group'
    page.should have_content 'room#7'
  end

  context 'edit, delete' do

    before do 
      @class_group = Factory(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
      visit class_groups_path
    end

    it 'should edit class group', :js => true do 
      click_link 'edit_link'
      wait_until { find('#class_group_modal').visible? }

      fill_in 'class_group_grade', :with => '2'
      fill_in 'class_group_name', :with => 'Really awesome class group'
      fill_in 'class_group_homeroom', :with => 'B2'

      click_button 'submit_button'

      page.should have_content '2'
      page.should have_content 'Really awesome class group'
      page.should have_content 'B2'

      page.should_not have_content '7'
      page.should_not have_content 'Awesome class group'
      page.should_not have_content 'room#7'
    end

    it 'should delete class group', :js => true do 
      tr_count = page.all('table.index tr').size
      page.should have_content(@class_group.name)

      click_link "delete_link" 
      page.driver.browser.switch_to.alert.accept
  
      wait_until { page.all('table.index tr').size == tr_count - 1 }
      ClassGroup.count.should == 0
      page.should_not have_content(@class_group.name)
    end
  end
end