require 'spec_helper'

describe Gaku::ExamsController do

  let(:exam) { create(:exam) }

  before do
    login_admin
  end

  describe "GET :index	" do
    it "should be successful" do
      gaku_get :index
      response.should be_success
    end
  end 

  describe "POST create" do
    it "redirects to the new exam" do
      page.stub :save => true

      exam = mock_model(Gaku::Exam,:attributes => true, :save => true)
      Gaku::Exam.stub(:new) { exam }
      gaku_post :create
      response.should redirect_to(gaku.exam_path(exam))
    end
  end

  describe "PUT update" do

    it "redirects to the exam" do
      page.stub :update_attributes => true

      gaku_post :update, :id => exam.id
      response.should redirect_to(gaku.exam_url(exam))
    end
  end

end