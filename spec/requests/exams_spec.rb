require 'spec_helper' 

describe 'Exams' do
	before(:each) do
		@exam = Factory(:exam)
		sign_in_as!(Factory(:user))
		within('ul#menu') { click_link "Exams"}
	end

	context do
		it 'should create new exam' do
			click_link 'new_exam_link'
			fill_in 'exam_name', :with => 'exam name'
			click_button 'Create Exam'  
		end	
	end

	context "showing exams" do
	  it "should have button for add portions" do
	   visit exam_path(@exam)
	   page.should have_link("Add Portion")
	  end
	end
end