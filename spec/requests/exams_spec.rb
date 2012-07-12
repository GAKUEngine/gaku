require 'spec_helper' 

describe 'Exams' do
  before(:each) do
    @exam = Factory(:exam, :name => "Linux", :max_score => 100)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Exams"}
  end

  context "create and edit exam" do

    #TODO Add execution_date and data
    it 'should create new exam' do
      click_link 'new_exam_link'
      fill_in 'exam_name', :with => 'Biology Exam'
      fill_in 'exam_problem_count', :with => 5
      fill_in 'exam_max_score', :with => 10
      fill_in 'exam_weight', :with => 1 
      fill_in 'exam_description', :with => "Good work"
      click_button 'Create Exam'  

      page.should have_content "was successfully created"
    end 

     pending "should edit exam" do 
      within('table.index tr:nth-child(2)') { click_link "Edit" }
      fill_in "exam_name", :with => "Biology Exam 2"
      fill_in "exam_problem_count", :with => 7
      click_button "Update Exam"

      page.should have_content("was successfully updated")
      page.should have_content("Biology Exam 2")
      page.should have_content("7")
    end
  end

  context "list and show exams" do
    pending "should list and show existing exams" do
      page.should have_content("Exams List")
      save_and_open_page
      within('table.index tr:nth-child(2)') { page.should have_content("Linux") }
      within('table.index tr:nth-child(2)') { page.should have_content("100") }
      
      # show
      within('table.index tr:nth-child(2)') { click_link "Show" }

      #TODO Make a real check when view is finished
      page.should have_content("Exam")
      page.should have_content("Linux")
      page.should have_content("100")

    end
  end
end