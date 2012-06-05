require 'spec_helper'

describe StudentsController do

  let(:student) { FactoryGirl.build_stubbed(:student) }

  before do
    login_admin
  end

  it "should have a current_user" do
    subject.current_user.should_not be_nil
  end

  describe "GET :index	" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end 
end