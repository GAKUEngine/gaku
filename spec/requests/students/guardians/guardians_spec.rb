require 'spec_helper'

describe 'Guardian' do
  stub_authorization!

  before do
    @student = create(:student)
    visit student_path(@student)
  end

  context 'new' do 
    before do 
      click_link 'new-student-guardian-tab-link'
      click_link 'new-student-guardian-link'
      wait_until { find('#new-student-guardian form').visible? } 
    end

    it "should add and show student guardian", :js => true do
      @student.guardians.size.should eql(0)
      !page.find('#new-student-guardian-link').visible?

      #required 
      fill_in "guardian_surname", :with => "Doe"
      fill_in "guardian_name", :with => "John"

      fill_in "guardian_surname_reading", :with => "Phonetic Doe"
      fill_in "guardian_name_reading", :with => "Phonetic John"
      fill_in "guardian_relationship", :with => "Father"

      click_button "submit-student-guardian-button"

      wait_until { !page.find('#new-student-guardian form').visible? }
      page.should have_selector('a', href: "/students/1/guardians/1/edit")
      #required
      page.should have_content("Doe")
      page.should have_content("John")

      page.should have_content("Phonetic Doe")
      page.should have_content("Phonetic John")
      page.should have_content("Father")
      within('.student-guardians-count') { page.should have_content('Guardians list(1)') }
      within('#new-student-guardian-tab-link') { page.should have_content('Guardians(1)') }
      @student.reload
      @student.guardians.size.should eql(1)
    end

    it 'should cancel adding', :js => true do
      click_link 'cancel-student-guardian-link'
      wait_until { !page.find('#new-student-guardian form').visible? }  
      find('#new-student-guardian-link').visible?

      click_link 'new-student-guardian-link'
      wait_until { find('#new-student-guardian form').visible? }  
      !page.find('#new-student-guardian-link').visible?
    end
  end

  context "edit and delete" do 
    before(:each) do 
      @guardian = create(:guardian)
      @student.guardians << @guardian
      @student.reload

      visit student_path(@student) 
      click_link 'new-student-guardian-tab-link'
      wait_until { page.has_content?('Guardians list') } 
    end

    it "should edit a student guardian", :js => true do 
      find(".edit-link").click 
      wait_until { find('#edit-guardian-modal').visible? } 

      fill_in 'guardian_name',    :with => 'Edited guardian name'
      fill_in 'guardian_surname', :with => 'Edited guardian surname'
      click_button "submit-student-guardian-button"

      wait_until { !page.find('#edit-guardian-modal').visible? }
      page.should have_content('Edited guardian name')
      page.should have_content('Edited guardian surname')
    end

    it 'should cancel editting', :js => true do 
      find(".edit-link").click 
      wait_until { find('#edit-guardian-modal').visible? }

      click_link 'cancel-student-guardian-link'
      wait_until { !page.find('#edit-guardian-modal').visible? }
    end

    it "should delete a student guardian", :js => true do
      @student.guardians.size.should eql(1)
      page.should have_content(@guardian.name)
      within('.student-guardians-count') { page.should have_content('Guardians list(1)') }
      within('#new-student-guardian-tab-link') { page.should have_content('Guardians(1)') }

      find('.delete-student-guardian-link').click 
      page.driver.browser.switch_to.alert.accept
      
      page.should_not have_content(@guardian.name)
      within('.student-guardians-count') { page.should_not have_content('Guardians list(1)') }
      within('#new-student-guardian-tab-link') { page.should_not have_content('Guardians(1)') }
      @student.reload
      @student.guardians.size.should eql(0)
    end
  end
  
end