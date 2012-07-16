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
    pending "redirects to the new exam" do
      page.stub :save => true

      post :create, :name => "biology"
      response.should redirect_to(exam_url(Exam.last))
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
      xhr :delete, :destroy, :id => exam
      controller.should_not set_the_flash
    end

    it "sets the flash" do
      delete :destroy, :id => exam
      controller.should set_the_flash
    end
  end
end