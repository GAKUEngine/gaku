require 'spec_helper'

describe "Admin School Campus Picture" do

  as_admin

  let(:school) { create(:school) }

  before do
    visit gaku.admin_school_path(school)
    click show_link
  end

  context "uploading", :js => true do
    it "uploads" do
      click_button "Change picture"
      absolute_path = Rails.root + "../support/120x120.jpg"
      attach_file 'campus_picture', absolute_path
      click_button "Upload"
      flash? "successfully uploaded"
    end
  end

end
