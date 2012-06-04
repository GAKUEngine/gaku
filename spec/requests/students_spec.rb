require 'spec_helper'

describe 'Student' do
  before(:each) do
    visit root_path
    save_and_open_page
    sign_in_as!(Factory(:user))
  end

  context "listing warehouses" do
    it "should list existing warehouses" do
      save_and_open_page
    end
  end
end
  