require 'spec_helper'

describe ProfilesController do

  let(:profile) { FactoryGirl.build_stubbed(:profile) }

  before do
    login_admin
  end

  describe "GET :index	" do
    pending "should be successful" do
      get :index
      response.should be_success
    end
  end 
  
end