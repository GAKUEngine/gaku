require 'spec_helper'

describe TeachersController do

  let(:teacher) { FactoryGirl.build_stubbed(:teacher) }

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
    it "redirects to the new teacher" do
      page.stub :save => true

      post :create
      response.should redirect_to(teacher_url(Teacher.last))
    end
  end
end