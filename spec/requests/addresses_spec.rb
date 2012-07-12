require 'spec_helper'

describe 'Addresses' do
  before do
    @address = Factory(:address)
    @student = Factory(:student)
    sign_in_as!(Factory(:user))
  end

  context "creating new address for student" do 
    it "should render new address partial in student form" do 
      within('ul#menu') { click_link "Students List"}
      click_link "new_student_link"
      within('ul#menu') { click_link "Class Listing"}
      click_link "new_class_group_link"
      page.should have_selector('div', :id => 'address')
    end
  end

  context "edit address" do
    it 'should edit address' do
      visit edit_student_address_path(@student, @address)
      page.should have_content "Edit Student Address"
    end
  end

end
