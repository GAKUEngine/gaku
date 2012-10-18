require 'spec_helper'

describe 'ClassGroups' do
  stub_authorization!

  before do
    visit class_groups_path
  end
  context 'new', :js => true do
    it 'creates and shows class group', :js => true do
      expect{
        click '#new-class-group-link'
        wait_until_visible '#submit-class-group-button' 
        fill_in 'class_group_grade', :with => '7'
        fill_in 'class_group_name', :with => 'Awesome class group'
        fill_in 'class_group_homeroom', :with => 'room#7'
        click '#submit-class-group-button'
        wait_until_invisible '#new-class-group' 
        }.to change(ClassGroup, :count).by 1 
      
      page.should have_content '7'
      page.should have_content 'Awesome class group'
      page.should have_content 'room#7'
    end

    it 'not create a class group without a name' do
      click '#new-class-group-link'
      wait_until_visible '#submit-class-group-button' 
      click_button 'submit-class-group-button'

      page.should have_content ('field is required')
    end

    it 'cancel creating' do
      expect{
        click_link 'new-class-group-link'
        wait_until_visible '#cancel-class-group-link'
        click_on 'cancel-class-group-link'
        wait_until_invisible '#new-class-group' 
        wait_until_visible '#new-class-group-link' 
        }.to change(ClassGroup,:count).by 0 
    end
  end
  
  context 'existing' do
    before do 
      @class_group = create(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
      visit class_groups_path
    end

    it 'edits a class group from index view', :js => true do 
      click edit_link
      wait_until_visible '#class-group-modal'

      fill_in 'class_group_grade', :with => '2'
      fill_in 'class_group_name', :with => 'Really awesome class group'
      fill_in 'class_group_homeroom', :with => 'B2'

      click '#submit-class-group-button'

      page.should have_content 'Really awesome class group'
      page.should have_content "2"
      page.should have_content "B2"

      page.should_not have_content 'Not so awesome class group'
      page.should_not have_content 'A1'

      edited_class_group = ClassGroup.last
      edited_class_group.name.should eq 'Really awesome class group'
      edited_class_group.grade.should eq 2
      edited_class_group.homeroom.should eq 'B2'
    end

    it 'cancels editting', :js => true do
      click edit_link 
      wait_until_visible '#class-group-modal' 
      click '#cancel-class-group-link'
      wait_until_invisible '#class-group-modal'
    end

    it 'edits a class group from show view', :js => true do 
      visit class_group_path(@class_group)
      click_link "Edit" 
      wait_until_visible '#class-group-modal' 

      fill_in 'class_group_grade', :with => '2'
      fill_in 'class_group_name', :with => 'Really awesome class group'
      fill_in 'class_group_homeroom', :with => 'B2'

      click '#submit-class-group-button'

      page.should have_content 'Really awesome class group' 
      page.should have_content "2"
      page.should have_content "B2"

      page.should_not have_content 'Not so awesome class group'
      page.should_not have_content 'A1'

      edited_class_group = ClassGroup.last
      edited_class_group.name.should eq 'Really awesome class group'
      edited_class_group.grade.should eq 2
      edited_class_group.homeroom.should eq 'B2'
    end

    it 'deletes a class group', :js => true do 
      page.should have_content(@class_group.name)
      expect{
          ensure_delete_is_working(delete_link,'table#class-groups-index tbody tr' )
        }.to change(ClassGroup,:count).by -1 
    
      page.should_not have_content(@class_group.name)
    end

    it 'returns to class_groups via Back button' do
      visit class_group_path(@class_group)
      click_on 'Back' 
      current_path.should == class_groups_path
    end
  end
end