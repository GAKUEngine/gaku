require 'spec_helper'

describe 'ClassGroup Semesters' do
  
  form          = '#new-class-group-semester'
  new_link      = '#new-class-group-semester-link'
  modal         = '#semester-modal'

  cancel_link   = '#cancel-class-group-semester-link'
  submit_button = '#submit-class-group-semester-button'
  
  table_rows    = 'table#class-group-semesters-index tbody tr'
  count_div     = '.class-group-semesters-count'
  tab_link      = '#class-group-semesters-tab-link'

  stub_authorization!
  
  before do
    @class_group = create(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
    @semester = create(:semester)
    visit class_group_path(@class_group)
    click tab_link
  end

  it 'add and show semester to a class group', :js => true do  
    page.should have_content "Semesters list"
    expect do
      click new_link
      wait_until_visible form

      select '2012', :from => 'semester_starting_1i'
      select 'September', :from => 'semester_starting_2i'
      select '28', :from => 'semester_starting_3i'

      select '2012', :from => 'semester_ending_1i'
      select 'December', :from => 'semester_ending_2i'
      select '20', :from => 'semester_ending_3i'
      click submit_button

      wait_until_invisible form
    end.to change(@class_group.semesters,:count).by 1
    
    within(table_rows){ page.should have_content('09/28/2012 - 12/20/2012') }
    within(count_div){ page.should have_content('1') }
  end

  it 'cancels adding', :js => true do
    click new_link
    wait_until_visible form

    click cancel_link
    wait_until_invisible form

    click new_link
    wait_until_visible form
  end

  context 'existing', :js => true do
    before do
      @class_group.semesters << @semester
      visit class_group_path(@class_group)

      click tab_link
      within(count_div){ page.should have_content('1') }
    end

    pending 'should not add a semester if it is already added' do 
      #TODO needs to be implemeted in the main logic
    end

    it 'edit semester' do
      click tab_link
      within(table_rows) { click edit_link }

      wait_until_visible modal

      select '2012', :from => 'semester_starting_1i'
      select 'September', :from => 'semester_starting_2i'
      select '15', :from => 'semester_starting_3i'

      select '2013', :from => 'semester_ending_1i'
      select 'February', :from => 'semester_ending_2i'
      select '15', :from => 'semester_ending_3i'
      click submit_button

      within(table_rows) { page.should have_content('09/15/2012 - 02/15/2013') }
      page.should_not have_content(modal)
    end

    it 'cancel editing', :js => true do
      size_of(table_rows).should eq 1

      within(table_rows) { click edit_link }
      wait_until_visible modal

      click cancel_link
      page.should_not have_content(modal)

    end

    it 'delete a semester from class group', :js => true do
      expect do
        ensure_delete_is_working(delete_link, table_rows)
      end.to change(@class_group.semesters,:count).by -1

      within(count_div) { page.should_not have_content('1') }
    end
  end

end