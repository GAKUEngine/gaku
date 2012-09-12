require 'spec_helper'

describe ExamsController do

  let(:exam) { FactoryGirl.create(:exam) }

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

      exam = mock_model(Exam,:attributes => true, :save => true)
      Exam.stub(:new) { exam }
      post :create
      response.should redirect_to(exam_url(exam))
    end
  end

  describe "PUT update" do

    it "redirects to the exam" do
      page.stub :update_attributes => true

      post :update, :id => exam.id
      response.should redirect_to(exam_url(exam))
    end
  end

  describe "destroying an exam" do

    it "doesn't set the flash on xhr requests'" do
      xhr :delete, :destroy, :id => exam.id
      controller.should_not set_the_flash
    end
  end
end