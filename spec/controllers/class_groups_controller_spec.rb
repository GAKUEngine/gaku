require 'spec_helper'

describe ClassGroupsController do

  let(:class_group) { FactoryGirl.build_stubbed(:class_group) }

  before do
    login_admin
  end

  describe "GET :index	" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end 

  describe "POST create" do
    it "redirects to the new class group" do
      page.stub :save => true

      post :create
      response.should redirect_to(class_group_url(ClassGroup.last))
    end
  end
end