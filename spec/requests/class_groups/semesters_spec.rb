require 'spec_helper'

describe 'ClassGroup Semesters' do
  stub_authorization!
  
  before do
    @class_group = Factory(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
    @semester = Factory(:semester)
    visit class_group_path(@class_group)
    click_link 'class_group_semesters_tab_link'
  end

  it 'should add and show semester to a class group', :js => true do  
    page.should have_content "Semesters list"
    @class_group.semesters.count.should eql(0)
    click_link 'add_class_group_semester_link'
    wait_until { page.find('#add_class_group_semester').visible? }

    select '2012', :from => 'semester_starting_1i'
    select 'September', :from => 'semester_starting_2i'
    select '28', :from => 'semester_starting_3i'

    select '2012', :from => 'semester_ending_1i'
    select 'December', :from => 'semester_ending_2i'
    select '20', :from => 'semester_ending_3i'
    click_button 'submit_semester_button'

    wait_until { !page.find('#add_class_group_semester').visible? }
    page.should have_content('09/28/2012 - 12/20/2012')
    @class_group.semesters.count.should eql(1)
  end

  context 'Class group with added semester', :js => true do
    before do
      @class_group.semesters << @semester
      visit class_group_path(@class_group)
    end

    pending 'should not add a semester if it is already added' do 
      #TODO needs to be implemeted in the main logic
    end

    it 'should edit semester' do
      click_link 'class_group_semesters_tab_link'

      within('table#semesters_index tbody') { click_link('edit_semester_link') }
      wait_until { find('#semester_modal').visible? }

      select '2012', :from => 'semester_starting_1i'
      select 'September', :from => 'semester_starting_2i'
      select '15', :from => 'semester_starting_3i'

      select '2013', :from => 'semester_ending_1i'
      select 'February', :from => 'semester_ending_2i'
      select '15', :from => 'semester_ending_3i'
      click_button 'submit_semester_button'

      within('table#semesters_index tbody') { page.should have_content('09/15/2012 - 02/15/2013') }
      page.should_not have_content('#semester_modal')
    end

    it 'should not edit a semester if cancel is clicked', :js => true do
      click_link 'class_group_semesters_tab_link'
      @class_group.semesters.count.should == 1
      page.all('table#semesters_index tbody tr').size.should == 1

      within('table#semesters_index tbody') { click_link('edit_semester_link') }
      wait_until { find('#semester_modal').visible? }

      select '2012', :from => 'semester_starting_1i'
      select 'September', :from => 'semester_starting_2i'
      select '15', :from => 'semester_starting_3i'

      select '2013', :from => 'semester_ending_1i'
      select 'February', :from => 'semester_ending_2i'
      select '15', :from => 'semester_ending_3i'
      click_on 'semester_cancel_link'
      page.should_not have_content('#semester_modal')

      within('table#semesters_index tbody') { 
        page.should_not have_content('09/15/2012 - 02/15/2013') }
    end

    it 'should delete a semester from class group', :js => true do
      click_link 'class_group_semesters_tab_link'    
      @class_group.semesters.count.should eql(1) 
      tr_count = page.all('table#semesters_index tbody tr').size

      click_link('delete_semester_link') 
      page.driver.browser.switch_to.alert.accept
 
      wait_until { page.all('table#semesters_index tbody tr').size == tr_count - 1 }
      @class_group.semesters.count.should eql(0)
    end
  end

end