require 'spec_helper'

describe TeachersController do

  let(:teacher) { FactoryGirl.create(:teacher) }

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

  describe "PUT update" do

    it "redirects to the teacher" do
      page.stub :update_attributes => true

      post :update, :id => teacher.id
      response.should redirect_to(teacher_url(teacher))
    end
  end

  describe "destroying a teacher" do

    it "doesn't set the flash on xhr requests'" do
      xhr :delete, :destroy, :id => teacher
      controller.should_not set_the_flash
    end

    pending "sets the flash" do
      delete :destroy, :id => teacher
      controller.should set_the_flash
    end
  end
end