require 'spec_helper'

describe ContactsController do

  let(:contact) { FactoryGirl.build_stubbed(:contact) }

  before do
    login_admin
  end

  describe "GET :index	" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end 
  
end