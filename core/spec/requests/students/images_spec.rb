require 'spec_helper'

describe "Student Images" do

  as_admin

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
      flash? "successfully uploaded"
    end
  end

end
