require 'spec_helper'

describe 'ClassGroups' do
  
  form          = '#new-class-group'
  new_link      = '#new-class-group-link'
  modal         = '#class-group-modal'
  
  cancel_link   = '#cancel-class-group-link'
  submit_button = '#submit-class-group-button'
  
  table_rows    = 'table#class-groups-index tbody tr'

  stub_authorization!

  before do
    visit class_groups_path
  end
  context 'new', :js => true do
    it 'creates and shows class group', :js => true do
      expect{
        click new_link
        wait_until_visible submit_button
        fill_in 'class_group_grade', :with => '7'
        fill_in 'class_group_name', :with => 'Awesome class group'
        fill_in 'class_group_homeroom', :with => 'room#7'
        click submit_button
        wait_until_invisible form 
        }.to change(ClassGroup, :count).by 1 
      
      page.should have_content '7'
      page.should have_content 'Awesome class group'
      page.should have_content 'room#7'
      page.should have_content 'successfully created'
    end

    it 'not create a class group without a name' do
      click new_link
      wait_until_visible submit_button 
      click submit_button

      page.should have_content ('field is required')
    end

    it 'cancel creating' do
      expect{
        click new_link
        wait_until_visible cancel_link
        click cancel_link
        wait_until_invisible form
        wait_until_visible new_link 
        }.to change(ClassGroup,:count).by 0 
    end
  end
  
  context 'existing' do
    before do 
      @class_group = create(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
      visit class_groups_path
    end

    context 'index/edit' do
      before do
        click edit_link
        wait_until_visible modal
      end
      it 'edits a class group', :js => true do 
        
        fill_in 'class_group_grade', :with => '2'
        fill_in 'class_group_name', :with => 'Really awesome class group'
        fill_in 'class_group_homeroom', :with => 'B2'

        click submit_button

        page.should have_content 'Really awesome class group'
        page.should have_content "2"
        page.should have_content "B2"

        page.should_not have_content 'Not so awesome class group'
        page.should_not have_content 'A1'

        edited_class_group = ClassGroup.last
        edited_class_group.name.should eq 'Really awesome class group'
        edited_class_group.grade.should eq 2
        edited_class_group.homeroom.should eq 'B2'
        page.should have_content 'successfully updated'
      end

      it 'cancels editting', :js => true do
        click cancel_link
        wait_until_invisible modal
      end
    end
    

    it 'edits a class group from show view', :js => true do 
      visit class_group_path(@class_group)
      click_link "Edit" 
      wait_until_visible modal 

      fill_in 'class_group_grade', :with => '2'
      fill_in 'class_group_name', :with => 'Really awesome class group'
      fill_in 'class_group_homeroom', :with => 'B2'

      click submit_button

      page.should have_content 'Really awesome class group' 
      page.should have_content "2"
      page.should have_content "B2"

      page.should_not have_content 'Not so awesome class group'
      page.should_not have_content 'A1'

      edited_class_group = ClassGroup.last
      edited_class_group.name.should eq 'Really awesome class group'
      edited_class_group.grade.should eq 2
      edited_class_group.homeroom.should eq 'B2'
      page.should have_content 'successfully updated'
    end

    it 'deletes a class group', :js => true do 
      page.should have_content(@class_group.name)
      expect{
          ensure_delete_is_working(delete_link,table_rows )
        }.to change(ClassGroup,:count).by -1 
    
      page.should_not have_content(@class_group.name)
      page.should have_content 'successfully destroyed'
    end

    it 'returns to class_groups via Back button' do
      visit class_group_path(@class_group)
      click_on 'Back' 
      current_path.should == class_groups_path
    end
  end
end