require 'spec_helper'

describe SemestersController do

  let(:semester) { FactoryGirl.create(:semester) }

  before do
    login_admin
  end

  describe "GET :index	" do
    pending "should be successful" do
      get :index
      response.should be_success
    end
  end 

  describe "POST create" do
    pending "redirects to the new semester" do
      page.stub :save => true

      post :create, :starting => semester.starting, :ending => semester.ending
      response.should redirect_to(semester_url(Semester.last))
    end
  end

  describe "PUT update" do

    it "redirects to the semester" do
      page.stub :update_attributes => true

      post :update, :id => semester.id
      response.should redirect_to(semester_url(semester))
    end
  end

  describe "destroying a semester" do

    it "doesn't set the flash on xhr requests'" do
      xhr :delete, :destroy, :id => semester
      controller.should_not set_the_flash
    end

    it "sets the flash" do
      delete :destroy, :id => semester
      controller.should set_the_flash
    end
  end
  
end