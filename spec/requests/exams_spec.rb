require 'spec_helper' 

describe 'Exams' do
  stub_authorization!

  before do
    visit exams_path
  end

  context 'not added exam' do

    it 'should create new exam' do  #TODO Add execution_date and data
      Exam.count.should == 0
      click_link 'new_exam_link'
      fill_in 'exam_name', :with => 'Biology Exam'
      fill_in 'exam_weight', :with => 1 
      fill_in 'exam_description', :with => "Good work"

      fill_in 'exam_exam_portions_attributes_0_name', :with => 'Exam Portion 1'
      fill_in 'exam_exam_portions_attributes_0_weight', :with => 1
      fill_in 'exam_exam_portions_attributes_0_problem_count', :with => 1 
      fill_in 'exam_exam_portions_attributes_0_max_score', :with => 1
      click_button 'Create Exam'  

      page.should have_content "was successfully created"
      Exam.count.should == 1
    end

    it 'should not submit new exam without filled validated fields' do
      Exam.count.should == 0
      click_link 'new_exam_link'
      # input only exam_portion fields to check validation on exam
      fill_in 'exam_exam_portions_attributes_0_weight', :with => 1
      fill_in 'exam_exam_portions_attributes_0_problem_count', :with => 1 
      fill_in 'exam_exam_portions_attributes_0_max_score', :with => 1
      click_button 'Create Exam'  

      page.should_not have_content "was successfully created"
      Exam.count.should == 0
    end 

    it 'should not submit new exam without filled validated fields for exam_portion' do
      Exam.count.should == 0
      click_link 'new_exam_link'
      # input only exam fields to check validation on exam
      fill_in 'exam_name', :with => 'Biology Exam'
      fill_in 'exam_weight', :with => 1 
      fill_in 'exam_description', :with => "Good work"
      click_button 'Create Exam'  

      page.should_not have_content "was successfully created"
      Exam.count.should == 0
    end 
  
    context 'with added exam' do
      before do
        @exam = Factory(:exam, :name => "Linux")
        visit exams_path
        Exam.count.should == 1
      end

      it 'should edit exam from index', :js => true do
        within('#exams-index') { find('#edit-exam-link').click }
        wait_until{ page.find('#edit-exam-modal').visible? }
        fill_in 'exam_name', :with => 'Biology 2012'
        click_button 'submit_button'
        wait_until{ !page.find('#edit-exam-modal').visible? }
        within('#exams-index') { page.should have_content('Biology 2012') }
      end

      it 'should show validation msgs on index/edit', :js => true do
        within('#exams-index') { find('#edit-exam-link').click }
        wait_until{ page.find('#edit-exam-modal').visible? }
        fill_in 'exam_name', :with => ''
        click_button 'submit_button'
        wait_until { page.should have_content 'This field is required' }
      end

      it 'should show weighting widget' do
        within('#exams-index') { find('#show-exam-link').click }
        page.should have_content('Weight')
        page.should have_content('Total Weight')
      end

      it 'should hide weighting widget',:js => true do
        within('#exams-index') { find('#edit-exam-link').click }
        wait_until{ page.find('#edit-exam-modal').visible? }
        uncheck 'Use Weighting'
        click_button 'submit_button'
        wait_until{ !page.find('#edit-exam-modal').visible? }
        page.should_not have_content('Total Weight')
        page.should have_no_selector(:content,'.weight-check-widget')
      end

      it 'should edit exam from show view', :js => true do
        within('#exams-index') { find('#show-exam-link').click }
        page.should have_content('Show Exam')
        click_on "Edit"
        page.should have_content('Edit Exam')
        fill_in 'exam_name', :with => 'Biology 2012'
        click_button 'submit_button'
        wait_until { page.should have_content('was successfully updated.') }
        page.should have_content('Biology 2012')
      end

      it 'should show validation msgs on view/edit', :js => true do
        within('#exams-index') { find('#show-exam-link').click }
        page.should have_content('Show Exam')
        click_on "Edit"
        page.should have_content('Edit Exam')
        fill_in 'exam_name', :with => ''
        click_button 'submit_button'
        wait_until { page.should have_content('This field is required') }
      end

      it 'should delete an exam', :js => true do
        within('#exams-index') { find('#delete-exam-link').click }
        page.driver.browser.switch_to.alert.accept
        page.should_not have_content("#{@exam.name}")
        Exam.count.should == 0
      end

      it 'should return to exams index when back selected' do
        visit exam_path(@exam)
        click_on 'Back'
        page.should have_content('Exams List')
      end
  
    end
  end
end