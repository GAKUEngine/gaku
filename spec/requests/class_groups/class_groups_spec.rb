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
    before do 
      click new_link
      wait_until_visible submit_button
    end

    it 'creates and shows class group', :js => true do
      expect do
        fill_in 'class_group_grade', :with => '7'
        fill_in 'class_group_name', :with => 'Awesome class group'
        fill_in 'class_group_homeroom', :with => 'room#7'
        click submit_button
        wait_until_invisible form 
      end.to change(ClassGroup, :count).by 1 
      
      page.should have_content '7'
      page.should have_content 'Awesome class group'
      page.should have_content 'room#7'
      flash 'successfully created'
    end

    it "errors without required fields" do
      click submit_button
      page.should have_content('field is required')
      flash_error_for 'class_group_name'
    end

    it 'cancels creating' do
      click cancel_link
      wait_until_invisible form
      visible? new_link 

      click new_link
      wait_until_visible submit_button
    end
  end
  
  context 'existing' do
    before do 
      @class_group = create(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
      visit class_groups_path
    end

    context 'edit', :js => true do
      before do
        click edit_link
        wait_until_visible modal
      end

      it 'edits a class group' do 
        fill_in 'class_group_grade',    :with => '2'
        fill_in 'class_group_name',     :with => 'Really awesome class group'
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
        flash 'successfully updated'
      end

      it 'cancels editting' do
        click cancel_link
        wait_until_invisible modal
      end

      it 'edits a class group from show view' do 
        visit class_group_path(@class_group)
        click edit_link
        wait_until_visible modal 

        fill_in 'class_group_grade',    :with => '2'
        fill_in 'class_group_name',     :with => 'Really awesome class group'
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
        flash 'successfully updated'
      end
    end

    it 'deletes a class group', :js => true do 
      page.should have_content(@class_group.name)

      expect do
        ensure_delete_is_working(delete_link,table_rows)
      end.to change(ClassGroup,:count).by -1 
    
      page.should_not have_content(@class_group.name)
      flash 'successfully destroyed'
    end

    it 'returns to class_groups via Back button' do
      visit class_group_path(@class_group)
      click_on 'back-class-group-link' 
      current_path.should eq class_groups_path
    end
  end
end