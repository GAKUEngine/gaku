require 'spec_helper'

describe 'Exams' do
	before(:each) do
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


end