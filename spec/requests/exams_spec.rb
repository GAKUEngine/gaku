require 'spec_helper' 

describe 'Exams' do
  stub_authorization!

  before(:each) do
    @exam = Factory(:exam, :name => "Linux")
    visit exams_path
  end

  context "create and edit exam" do

    it 'should create new exam' do  #TODO Add execution_date and data
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
      #TODO check model creation
    end 

    it 'should not submit new exam without filled validated fields' do
      click_link 'new_exam_link'
      # input only exam_portion fields to check validation on exam
      fill_in 'exam_exam_portions_attributes_0_weight', :with => 1
      fill_in 'exam_exam_portions_attributes_0_problem_count', :with => 1 
      fill_in 'exam_exam_portions_attributes_0_max_score', :with => 1
      click_button 'Create Exam'  

      page.should_not have_content "was successfully created"
    end 

    it 'should not submit new exam without filled validated fields for exam_portion' do
      click_link 'new_exam_link'
      # input only exam fields to check validation on exam
      fill_in 'exam_name', :with => 'Biology Exam'
      fill_in 'exam_weight', :with => 1 
      fill_in 'exam_description', :with => "Good work"
      click_button 'Create Exam'  

      page.should_not have_content "was successfully created"
    end 
  end

end