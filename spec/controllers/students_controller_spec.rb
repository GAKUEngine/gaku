require 'spec_helper'

describe StudentsController do

  before do
    controller.stub :current_user => Factory(:user)
  end

  describe "GET :index	" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end 
end