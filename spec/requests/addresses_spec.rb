require 'spec_helper'

describe 'Addresses' do
  before do
    @address = Factory(:address)
    @student = Factory(:student)
    sign_in_as!(Factory(:user))
  end

  context "creating new address for student" do 
    pending "should render new address partial in student form" do 
      #TODO
    end
  end

  context "edit address" do
    it 'should edit address' do
      visit edit_student_address_path(@student, @address)
      page.should have_content "Edit Student Address"
    end
  end

end
