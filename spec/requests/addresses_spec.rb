require 'spec_helper'

describe 'Addresses' do
  before do
    @address = Factory(:address)
    sign_in_as!(Factory(:user))
  end

  context "creating new address for student" do 
    it "should render new address partial in student form" do 
      within('ul#menu') { click_link "Students List"}
      click_link "new_student_link"
      within('ul#menu') { click_link "Class Listing"}
      click_link "new_class_group_link"
      page.should have_selector('div',   id:   'address')

    end
  end
end
