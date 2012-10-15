require 'spec_helper'

describe 'ClassGroup Semesters' do
  stub_authorization!
  
  before do
    @class_group = create(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1')
    @semester = create(:semester)
    visit class_group_path(@class_group)
    click_link 'class-group-semesters-tab-link'
  end

  it 'should add and show semester to a class group', :js => true do  
    page.should have_content "Semesters list"
    @class_group.semesters.count.should eql(0)
    click_link 'new-class-group-semester-link'
    wait_until { page.find('#new-class-group-semester form').visible? }

    select '2012', :from => 'semester_starting_1i'
    select 'September', :from => 'semester_starting_2i'
    select '28', :from => 'semester_starting_3i'

    select '2012', :from => 'semester_ending_1i'
    select 'December', :from => 'semester_ending_2i'
    select '20', :from => 'semester_ending_3i'
    click_button 'submit-class-group-semester-button'

    wait_until { !page.find('#new-class-group-semester form').visible? }
    within('#class-group-semesters-index'){ page.should have_content('09/28/2012 - 12/20/2012') }
    @class_group.semesters.count.should eq 1
    within('.class-group-semesters-count'){ page.should have_content('1') }
  end

  it 'should not add a semester if cancel btn is clicked', :js => true do
    @class_group.semesters.count.should eq 0
    click_link 'new-class-group-semester-link'
    wait_until { page.find('#new-class-group-semester form').visible? }

    click_on 'cancel-class-group-semester-link'

    wait_until { !page.find('#new-class-group-semester form').visible? }
  
    @class_group.semesters.count.should eq 0
    within('.class-group-semesters-count') { page.should_not have_content('1') }
  end

  context 'Class group with added semester', :js => true do
    before do
      @class_group.semesters << @semester
      visit class_group_path(@class_group)

      click_link 'class-group-semesters-tab-link'
      within('.class-group-semesters-count'){ page.should have_content('1') }
    end

    pending 'should not add a semester if it is already added' do 
      #TODO needs to be implemeted in the main logic
    end

    it 'should edit semester' do
      click_link 'class-group-semesters-tab-link'
      within('table#class-group-semesters-index tbody') { find('.edit-link').click }

      wait_until { find('#semester-modal').visible? }

      select '2012', :from => 'semester_starting_1i'
      select 'September', :from => 'semester_starting_2i'
      select '15', :from => 'semester_starting_3i'

      select '2013', :from => 'semester_ending_1i'
      select 'February', :from => 'semester_ending_2i'
      select '15', :from => 'semester_ending_3i'
      click_button 'submit-class-group-semester-button'

      within('table#class-group-semesters-index tbody') { page.should have_content('09/15/2012 - 02/15/2013') }
      page.should_not have_content('#semester-modal')
    end

    it 'should not edit a semester if cancel is clicked', :js => true do
      @class_group.semesters.count.should eq 1
      page.all('table#class-group-semesters-index tbody tr').size.should eql(1)

      within('table#class-group-semesters-index tbody') { find('.edit-link').click }
      wait_until { find('#semester-modal').visible? }

      select '2012', :from => 'semester_starting_1i'
      select 'September', :from => 'semester_starting_2i'
      select '15', :from => 'semester_starting_3i'

      select '2013', :from => 'semester_ending_1i'
      select 'February', :from => 'semester_ending_2i'
      select '15', :from => 'semester_ending_3i'
      click_on 'cancel-class-group-semester-link'
      page.should_not have_content('#semester-modal')

      within('table#class-group-semesters-index tbody') do
        page.should_not have_content('09/15/2012 - 02/15/2013') 
      end
    end

    it 'should delete a semester from class group', :js => true do
      @class_group.semesters.count.should eq 1
      tr_count = page.all('table#class-group-semesters-index tbody tr').size

      find('.delete-link').click 
      page.driver.browser.switch_to.alert.accept
 
      wait_until { page.all('table#class-group-semesters-index tbody tr').size == tr_count - 1 }
      @class_group.semesters.count.should eq 0
      within('.class-group-semesters-count') { page.should_not have_content('1') }
    end
  end

end