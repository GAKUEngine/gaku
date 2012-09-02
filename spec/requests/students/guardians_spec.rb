require 'spec_helper'

describe 'Guardian' do
  stub_authorization!

  before do
    @student = Factory(:student)
    #within('ul#menu') { click_link "Students"}
    visit student_path(@student)
  end

  it "should add and show student guardian", :js => true do
    click_link 'new_student_guardian_tab_link'
    click_link 'new_student_guardian_link'

    wait_until { page.has_content?('Relationship') } 

    #required 
    fill_in "guardian_surname", :with => "Doe"
    fill_in "guardian_name", :with => "John"

    fill_in "guardian_surname_reading", :with => "Phonetic Doe"
    fill_in "guardian_name_reading", :with => "Phonetic John"
    fill_in "guardian_relationship", :with => "Father"

    click_button "Save Guardian"

    page.should have_selector('a', href: "/students/1/guardians/1/edit")

    #required
    page.should have_content("Doe")
    page.should have_content("John")

    page.should have_content("Phonetic Doe")
    page.should have_content("Phonetic John")
    page.should have_content("Father")
    @student.guardians.size.should == 1

  end

  context "edit and delete" do 

    before(:each) do 
      @guardian = Factory(:guardian)
      @student.guardians << @guardian
      @student.reload

      visit student_path(@student) 
      click_link 'new_student_guardian_tab_link'
      wait_until { page.has_content?('Guardians List') } 
    end

    it "should edit a student guardian", :js => true do 
      click_link "edit_link" 
      wait_until { find('#editGuardianModal').visible? } 

      fill_in 'guardian_name',    :with => 'Edited guardian name'
      fill_in 'guardian_surname', :with => 'Edited guardian surname'

      click_button 'submit_button'
      #click_link 'cancel_link'
      wait_until { !page.find('#editGuardianModal').visible? }

      page.should have_content('Edited guardian name')
      page.should have_content('Edited guardian surname')
    end

    it "should delete a student guardian", :js => true do
      #page.all('table.index tr').size.should == 2
      page.should have_content(@guardian.name)
      #@student.guardians.size.should == 1

      click_link 'delete_link' 
      page.driver.browser.switch_to.alert.accept
      #FIXME Make a real check, no sleep 
      sleep 1
      #page.all('table.index tr').size.should == 2
      #@student.guardians.size.should == 0
      page.should_not have_content(@guardian.name)
    end

  end
end