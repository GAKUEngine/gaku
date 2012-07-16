require 'spec_helper'

describe AddressesController do

  let(:address) { FactoryGirl.build_stubbed(:address) }
  let(:student) {Factory(:student)}
  let(:state) {Factory(:state)}
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