require 'spec_helper'

describe ExamsController do

  let(:exam) { FactoryGirl.build_stubbed(:exam) }

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
    it "redirects to the new exam" do
      page.stub :save => true

      post :create
      response.should redirect_to(exam_url(Exam.last))
    end
  end
end