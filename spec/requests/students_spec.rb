require 'spec_helper'

describe 'Student' do
  before do
    @student1 = Factory(:student)
    sign_in_as!(Factory(:user))
  end

  context "listing students" do
    it "should list existing students" do
      visit students_path
      #save_and_open_page
      #page.should have_content @student1.name
    end
  end
end