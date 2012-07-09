require 'spec_helper'

describe 'Addresses' do
	before(:each) do
		sign_in_as!(Factory(:user))
		@student = Factory(:student)
		@address = Factory(:address)
	end
	
	context "edit address" do
		it 'should edit address' do
			visit edit_student_address_path(@student, @address)
			page.should have_content "Edit Student Address"
		end
	end

end