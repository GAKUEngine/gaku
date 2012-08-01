require 'spec_helper'

describe AddressesController do

  let(:address) { FactoryGirl.build_stubbed(:address) }

  before do
    login_admin
  end

  describe "GET :index" do 
    it "should be successful" do
      get :index
      response.should be_success
    end
  end 
end