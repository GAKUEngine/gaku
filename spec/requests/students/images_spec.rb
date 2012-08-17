require 'spec_helper'

describe "Student Images" do
  before do
    @student = Factory(:student)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Students" }
  end

  context "uploading and editing an image", :js => true do
    it "should allow to upload and edit an image for a student" do
      visit student_path(@student)
      click_button "Change picture"
      absolute_path = Rails.root + "spec/support/120x120.jpg"
      attach_file('student_picture', absolute_path)
      click_button "Upload"
      page.should have_content("Picture successfully uploaded")
    end
  end
end