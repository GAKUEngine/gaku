require 'spec_helper'

describe "Student Images" do

  stub_authorization!
  
  let(:student) { create(:student) }
  
  before do 
    visit gaku.student_path(student)
  end

  context "uploading", :js => true do
    it "uploads" do
      click_button "Change picture"
      absolute_path = Rails.root + "../support/120x120.jpg"
      attach_file 'student_picture', absolute_path
      click_button "Upload"
      flash? "Picture was successfully uploaded"
    end
  end
  
end