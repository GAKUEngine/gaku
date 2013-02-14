require 'spec_helper'

describe "Teacher Picture" do

  as_admin

  let(:teacher) { create(:teacher) }

  before do
    visit gaku.teacher_path(teacher)
  end

  context "uploading", :js => true do
    it "uploads" do
      click_button "Change picture"
      absolute_path = Rails.root + "../support/120x120.jpg"
      attach_file 'teacher_picture', absolute_path
      click_button "Upload"
      flash? "successfully uploaded"
    end
  end

end
