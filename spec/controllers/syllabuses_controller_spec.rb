require 'spec_helper'

describe SyllabusesController do

  let(:syllabus) { FactoryGirl.create(:syllabus) }

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
    it "redirects to the new syllabus" do
      page.stub :save => true

      post :create
      response.should redirect_to(syllabus_url(Syllabus.last))
    end
  end

  describe "PUT update" do

    it "redirects to the syllabus" do
      page.stub :update_attributes => true

      post :update, :id => syllabus.id
      response.should redirect_to(syllabus_url(syllabus))
    end
  end

  describe "destroying a syllabus" do

    it "doesn't set the flash on xhr requests'" do
      xhr :delete, :destroy, :id => syllabus
      controller.should_not set_the_flash
    end

    it "sets the flash" do
      delete :destroy, :id => syllabus
      controller.should set_the_flash
    end
  end
end