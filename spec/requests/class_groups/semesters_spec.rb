require 'spec_helper'

describe 'ClassGroup Semesters' do

  stub_authorization!

  before :all do
    Helpers::Request.resource("class-group-semester")
  end
  
  before do
    @class_group = create(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
    @semester = create(:semester, :starting => "2012-10-21", :ending => "2012-11-21")
    visit class_group_path(@class_group)
    click tab_link
  end

  context 'new', :js => true do
    before do 
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows semester' do  
      expect do
        select '2012',      :from => 'semester_starting_1i'
        select 'September', :from => 'semester_starting_2i'
        select '28',        :from => 'semester_starting_3i'

        select '2012',      :from => 'semester_ending_1i'
        select 'December',  :from => 'semester_ending_2i'
        select '20',        :from => 'semester_ending_3i'
        click submit
        wait_until_invisible form
      end.to change(@class_group.semesters,:count).by 1
      
      within(table) { page.should have_content '09/28/2012 - 12/20/2012' }
      within(count_div) { page.should have_content 'Semesters list(1)' }
      within(tab_link) { page.should have_content 'Semesters(1)' }
      flash_created?
    end

    it 'cancels creating' do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing', :js => true do
    before do
      @class_group.semesters << @semester
      visit class_group_path(@class_group)
      click tab_link
      within(count_div) { page.should have_content '1' }
    end

    pending "doesn't create a semester if it is already created" do 
      #TODO needs to be implemeted in the main logic
    end

    context 'edit', :js => true do
      before do 
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits semester' do
        select '2012',      :from => 'semester_starting_1i'
        select 'September', :from => 'semester_starting_2i'
        select '15',        :from => 'semester_starting_3i'

        select '2013',      :from => 'semester_ending_1i'
        select 'February',  :from => 'semester_ending_2i'
        select '15',        :from => 'semester_ending_3i'
        click submit
        
        wait_until_invisible modal
        within(table) { page.should have_content '09/15/2012 - 02/15/2013' }
        within(table) { page.should_not have_content '10/21/2012 - 11/21/2012' }
        flash_updated?
      end

      it 'cancels editing' do
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes semester', :js => true do
      page.should have_content '10/21/2012 - 11/21/2012'
      within(count_div) { page.should have_content 'Semesters list(1)' }
      within(tab_link) { page.should have_content 'Semesters(1)' }

      expect do
        ensure_delete_is_working
      end.to change(@class_group.semesters,:count).by -1
      
      within(count_div) { page.should_not have_content 'Semesters list(1)' }
      within(tab_link) { page.should_not have_content 'Semesters(1)' }
      page.should_not have_content '10/21/2012 - 11/21/2012'
      flash_destroyed?
    end
  end

end